---
title: Agent0 深度分析 (Unleashing Self-Evolving Agents from Zero Data)
created: 2026-04-13
updated: 2026-04-13
type: query
tags: [paper-analysis, zero-data, tool-using-agent, curriculum-learning, reinforcement-learning]
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# Agent0 深度分析 (Unleashing Self-Evolving Agents from Zero Data)

**原文**: [arXiv:2511.16043](https://arxiv.org/abs/2511.16043)  
**作者**: Peng Xia, Kaide Zeng, Jiaqi Liu, Can Qin, Fang Wu, Yiyang Zhou, Caiming Xiong, Huaxiu Yao  
**机构**: UNC-Chapel Hill, Salesforce Research, Stanford University  
**代码**: https://github.com/aiming-lab/Agent0

---

## 1. 核心问题与动机

大型语言模型（LLM）Agent 的训练长期受制于一个瓶颈：**对人类标注数据的高度依赖**。无论是监督微调（SFT）还是基于人类反馈的强化学习（RLHF），都需要大量的人工标注，这不仅成本高昂，而且限制了模型的能力边界——模型很难学会人类数据中未曾涵盖的新技能。

现有的 self-evolution（自我进化）框架虽然减少了对人工数据的需求，但普遍存在两个限制：
1. **仅支持单轮交互**：大多数方法只能在纯文本空间中进行单轮推理，无法利用 Python 解释器、搜索引擎等外部工具。
2. **受限于模型固有能力**：它们生成的训练数据不会显著超出模型原本的分布，因此无法真正"教"模型学会它原本不会的东西。

Agent0 的动机是：**能否在完全没有外部数据的情况下，通过多轮协同进化和工具集成，从零培养出高能力的 LLM Agent？**

---

## 2. 关键结论与贡献

**核心贡献：**

1. **完全零数据的自主进化框架**：Agent0 不需要任何人工标注数据，仅通过两个同源 Agent 的协同竞争就能自我进化。
2. **原生多轮工具集成**：支持 Agent 在推理过程中生成并执行 Python 代码，实现 "thinking by coding"。
3. **ADPO 算法**：提出 Ambiguity-Dynamic Policy Optimization，一种能处理自一致性多数投票产生的噪声伪标签的动态 RL 算法。
4. **动态课程生成**：Curriculum Agent 能根据 Executor 的能力边界（uncertainty = 0.5 为最佳）自动生成难度适配的训练任务。

**关键结论：**
- Qwen3-8B-Base + Agent0：数学推理提升 **+18%**，通用推理提升 **+24%**
- Qwen3-4B-Base + Agent0：数学推理提升 **+23%**，通用推理提升 **+39%**
- 超越 Socratic-Zero (+3.7%)、R-Zero (+6.4%)、Absolute Zero (+10.6%)

---

## 3. 详细研究方法

### 3.1 双 Agent 协同进化架构

Agent0 的核心是一个**共生竞争系统**：

| Agent | 符号 | 训练算法 | 职责 |
|-------|------|---------|------|
| **Curriculum Agent** | $\pi_\theta$ | GRPO | 生成"刚刚好"难度的训练任务 |
| **Executor Agent** | $\pi_\phi$ | ADPO | 学习解决任务，支持多轮工具调用 |

**进化逻辑**：Executor 学会使用工具 → 能解决更复杂问题 → Curriculum Agent 被迫生成更难的工具依赖型任务 → Executor 进一步被逼着进化。这是一个**正反馈循环**。

### 3.2 Curriculum Agent 的奖励设计

Curriculum Agent 的目标是生成让 Executor "半会半不会"的题目。难度由 Executor 的**自一致性（self-consistency）** 来衡量：

**不确定性奖励**（在 $\hat{p}=0.5$ 时最大）：
$$R_{unc}(x; \pi_\phi) = 1 - 2|\hat{p}(x; \pi_\phi) - 0.5|$$

其中 $\hat{p}$ 是 Executor 对同一道题生成 $k=10$ 个答案后， majority vote 的得票比例。如果 Executor 10 次中有 5 次答对，说明题目刚好在能力边界上。

**工具使用奖励**：
$$R_{tool}(x; \pi_\phi) = \gamma \cdot \min(N_{tool}(y), C)$$
其中 $N_{tool}(y)$ 统计答案中工具调用标记（如 ```output）的数量，$C=4$ 防止过度调用。

**重复惩罚**（基于 BLEU 聚类）：
$$R_{rep}(x_i) = \lambda_{rep} \cdot \frac{|C_k|}{B}$$
防止 Curriculum Agent 生成语义重复的变体题。

**复合奖励**：
$$R_C(x_i) = R_{format}(x_i) \cdot \max(0, (\lambda_{unc}R_{unc} + \lambda_{tool}R_{tool}) - R_{rep}(x_i))$$

### 3.3 Executor Agent：ADPO

Executor 面临一个经典难题：**没有 ground-truth label**，只能用 majority voting 作为 pseudo-label。但当自一致性 $\hat{p}$ 很低时，这个 pseudo-label 非常不可靠。

**ADPO 的核心创新**：

#### (1) 模糊感知优势缩放（Ambiguity-Aware Advantage Scaling）
对高模糊度（低一致性）样本的 advantage 进行降权：
$$\tilde{A}_i(x) = \hat{A}_i \cdot s(x)$$
其中 $s(x) = f(\hat{p}(x))$ 是关于自一致性的增函数。也就是说，Executor 越不确定的题目，对策略梯度的影响越小。

#### (2) 动态信任域（Dynamic Trust Regions）
传统 PPO/GRPO 使用固定的 clip bound $\epsilon$。ADPO 将 upper bound 设为 $\hat{p}$ 的减函数：
- **低一致性**（题目很难或很模糊）→ $\epsilon_{high}$ 变大 → 允许模型探索更多非常规推理路径
- **高一致性**（题目很清晰）→ $\epsilon_{high}$ 变小 → 约束模型不要偏离可靠的伪标签

**ADPO 目标函数**：
$$\mathcal{L}_{ADPO}(\theta) = -\mathbb{E}\left[\min\left(r_i(\theta)\tilde{A}_i(x), \text{clip}(r_i(\theta), 1-\epsilon_{low}, 1+\epsilon_{high}(x))\tilde{A}_i(x)\right)\right]$$

### 3.4 多轮工具集成协议

Executor 的交互流程如下：
1. 生成自然语言推理 + Python 代码块（```python...```）
2. 生成被截断，代码在 sandbox 中执行
3. 执行结果以 ```output...``` 的形式追加到上下文中
4. Executor 基于 [历史 + 新反馈] 继续推理
5. 重复直到输出最终答案 $\boxed{...}$

这种 "stop-and-go" 的执行模式让 LLM 可以把复杂计算外化给 Python，从而专注于高层推理策略。

### 3.5 数据集筛选：能力前沿（Capability Frontier）

不是所有生成的任务都适合训练。Agent0 只保留那些 Executor "半会半不会"的任务：
$$D^{(t)} = \{(x, \hat{p}, \tilde{y}) \mid |\hat{p}(x; \pi_\phi^{(t-1)}) - 0.5| \leq \delta\}$$
其中 $\delta = 0.25$，即保留 $\hat{p} \in [0.3, 0.8]$ 的任务。太容易（$\hat{p} \to 1$）没有学习价值，太难（$\hat{p} \to 0$）则只会引入噪声。

---

## 4. 实验结果与发现

### 4.1 实验设置
- **基准**：AMC, Minerva, MATH, GSM8K, Olympiad-Bench, AIME24/25, SuperGPQA, MMLU-Pro, BBEH
- **模型**：Qwen3-8B-Base, Qwen3-4B-Base
- **Baseline**：Qwen3-Base 自身、Socratic-Zero、R-Zero、Absolute Zero
- **迭代次数**：T = 3

### 4.2 主要结果

| 模型 | Math AVG | General AVG |
|------|---------|-------------|
| Qwen3-8B-Base | 49.2 | 34.5 |
| **+ Agent0** | **58.2** (+18%) | **42.1** (+24%) |
| Qwen3-4B-Base | 42.6 | 27.1 |
| **+ Agent0** | **52.5** (+23%) | **37.6** (+39%) |

Agent0 在所有 benchmark 上都一致领先，且相比其他零数据方法的领先优势非常明显。

### 4.3 课程复杂度演进

| 迭代 | 固定 Executor 通过率 | 平均工具调用次数 |
|-----|---------------------|-----------------|
| 1 | 65% | 1.2 |
| 2 | 48% | 2.1 |
| 3 | 35% | 2.8 |

这个表格非常关键：随着迭代进行，生成的任务对固定能力的 Executor 来说越来越难，而且越来越依赖工具。这证明了课程 Agent 确实在不断 push 能力边界。

---

## 5. 实践意义及启示

1. **零数据冷启动**：对于企业内部部署的私有 Agent（如内部数据库查询、专有工具调用），往往缺乏标注数据。Agent0 提供了一条从零开始构建能力的可行路径。
2. **工具增强推理的典范**：Agent0 展示了 LLM 不应该只停留在文本推理，而应该学会把"不会算的交给 Python"，这与人类使用计算器的模式高度一致。
3. **ADPO 的泛用性**：ADPO 处理噪声 pseudo-label 的思路不仅适用于 Agent0，也适用于所有自举式 RL 场景（如 self-play、self-improvement）。
4. **自动课程生成**：Trainer/Curriculum Agent 的架构可以被广泛应用于教育科技、游戏 AI 等领域。

---

## 6. 局限性与未来方向

1. **Sandbox 基础设施依赖**：多轮代码执行需要安全、稳定的隔离环境，这在实际部署中增加了工程复杂度。
2. **仅限可符号化验证的领域**：虽然比 SAGE 更通用，但 Agent0 仍然依赖多数投票的一致性作为训练信号，对于完全开放式的任务仍然束手无策。
3. **两 Agent 训练的稳定性**：共生竞争系统可能存在循环崩溃的风险，例如 Curriculum Agent 生成的任务过于简单或过于困难，导致 Executor 无法学习。
4. **计算成本高**：每个训练样本都需要采样 $k=10$ 次来估计 $\hat{p}$，这比单采样训练昂贵得多。

**未来方向**：
- 引入更复杂的工具生态（如浏览器、数据库、API 调用）。
- 研究 Curriculum Agent 如何生成跨模态任务（如结合图像和代码）。
- 将 ADPO 推广到更多 RL 算法（如 DPO、PPO）。

---

## 7. 影响分析

Agent0 的影响是深远的：

1. **方法论上**，它证明了**工具集成 + 零数据 + 协同进化**的三元组是可行的，并且效果显著。这可能会引发一波"Tool-Augmented Self-Evolution"的研究热潮。
2. **工程上**，它为冷启动场景提供了一个极具吸引力的 pipeline。任何拥有基础 LLM 和 sandbox 环境的团队，都可以尝试复制 Agent0 的框架。
3. **概念上**，它将 LLM 从"纯文本推理器"重新定位为"工具编排者"（tool orchestrator），这与当前 AI 产业界的发展方向高度一致。

---

## 8. 关键问题及解答

**Q1：Agent0 和 SAGE 都使用多 Agent 对抗，它们的核心区别是什么？**
> A：SAGE 使用 4 个 Agent（Challenger/Planner/Solver/Critic），主要关注数学/代码等可验证领域，不依赖外部工具。Agent0 使用 2 个 Agent（Curriculum/Executor），核心创新在于**原生多轮工具集成**和**零数据**，应用领域更通用（数学+通用推理）。

**Q2：为什么 Curriculum Agent 的最佳难度目标是 Executor 自一致性为 0.5？**
> A：0.5 表示 Executor 对这道题"知道一些，但又不完全确定"。如果一致性接近 1.0，说明题目太简单，没有学习价值；接近 0.0，说明题目太难，pseudo-label 几乎随机，无法提供有效训练信号。0.5 是 Vygotsky "最近发展区"（Zone of Proximal Development）的数学体现。

**Q3：ADPO 的动态信任域会不会导致训练不稳定？**
> A：论文的实验结果表明 ADPO 是稳定的。其直觉在于：对于模糊样本放宽约束是合理的，因为此时 pseudo-label 本身就不太可靠，过度约束反而会让模型陷入错误的局部最优；而对于清晰样本收紧约束，则保证了模型不会偏离已知的正确答案。

**Q4：Agent0 是否能完全替代人类标注？**
> A：在数学、代码等可以通过符号计算或多数投票验证的领域，答案是"几乎能"。但在创意写作、情感分析、开放对话等主观领域，仍然需要人类反馈或其他形式的评估器。

---

## 9. 前人研究情况

Agent0 建立在以下几个研究脉络之上：

1. **Zero-Data Learning**：Socratic-Zero 通过苏格拉底式提问生成数据；R-Zero 使用规则的自我博弈；Absolute Zero 使用符号引擎生成数学证明。Agent0 超越了这些方法，加入了工具集成和动态课程。
2. **Tool-Augmented LLMs**：如 ReAct、ToolFormer 等证明了 LLM 可以使用外部工具。Agent0 将工具使用从推理阶段扩展到了**训练阶段**。
3. **Curriculum Learning**：从 Bengio 到近期的 WebRL、AgentEvolver，自动生成训练课程一直是一个活跃方向。Agent0 的创新在于课程难度由学习者的实时能力动态决定。
4. **GRPO / PPO**：Executor 和 Curriculum Agent 都基于近端策略优化类算法，ADPO 是对 GRPO 的重要扩展。

---

## 10. 实例推演

### 10.1 逐步推演

**场景**：Agent0 正在从零训练一个解决数学应用题的 Executor。这是第 2 轮迭代。

**Step 1：Curriculum Agent 生成任务**
Curriculum Agent 从基础数学概念出发，生成题目："计算 $\sqrt{144} + 13^2 - \frac{1}{0.25}$ 的值。"

**Step 2：Executor 采样 10 次并投票**
Executor 对这道题生成 10 个回答：
- 5 个回答算出 169（正确）
- 3 个回答算出 173（忽略了 $\frac{1}{0.25}=4$）
- 2 个回答格式错误

自一致性 $\hat{p} = 5/10 = 0.5$。

**Step 3：任务筛选**
$|0.5 - 0.5| = 0.0 \leq \delta=0.25$，这道题被保留进训练集 $D^{(2)}$。

**Step 4：Executor 使用工具解题（展示一次正确轨迹）**
Executor 输出：
```
我需要分步计算这个表达式。先算平方根和平方，然后用 Python 验证。
```python
import math
result = math.sqrt(144) + 13**2 - 1/0.25
print(result)
```
```output
169.0
```
所以答案是 $\boxed{169}$。
```

**Step 5：ADPO 训练**
由于 $\hat{p}=0.5$（中等模糊度），ADPO 的 advantage scaling 给这个样本一个中等权重，同时动态信任域放宽，允许 Executor 探索不同的计算分解方式。

**Step 6：下一轮迭代**
随着 Executor 学会使用 Python 处理复杂算式，Curriculum Agent 会生成更难的题（如包含积分、矩阵运算），继续把 $\hat{p}$ 维持在 0.5 附近。

### 10.2 通俗解释

想象一个老师在教一个学生数学，但这个老师没有教科书，也没有任何现成的习题册。老师的教学方法是：

1. 先随便出一道数学题给学生做。
2. 学生做 10 遍，如果 5 遍对 5 遍错，说明这道题刚刚好——学生努努力就能学会。
3. 如果学生 10 遍全对，老师就提高难度；如果 10 遍全错，老师就降低难度。
4. 学生被允许使用计算器（Python）。他发现复杂计算交给计算器后，自己只需要专注思考"怎么列式子"。

Agent0 就是这样一种"自适应家教系统"：老师永远出"刚刚好"难度的题，学生永远在被挑战但不被压垮的舒适区边缘学习，还能借助工具突破自己的计算瓶颈。

---

## 11. 总结

Agent0 是 2025-2026 年间最具影响力的 Agent 自我进化工作之一。它突破了"人类数据依赖"和"单轮推理"的双重限制，通过**Curriculum Agent 与 Executor Agent 的协同进化**，配合**原生多轮工具集成**和**ADPO 动态优化算法**，实现了真正的零数据高能力 Agent 培养。

实验结果令人印象深刻：在 Qwen3-8B 上，数学推理提升 18%，通用推理提升 24%；在更小的 4B 模型上提升甚至更为显著。这不仅是一个算法上的胜利，更预示着未来 LLM Agent 的训练范式可能发生根本性转变——从"人类教我"转向"我自己教自己"。

不过，Agent0 对 sandbox 基础设施的依赖，以及在完全开放领域应用的困难，仍然是未来需要克服的挑战。

---

## 12. 相关推荐

**12.1 论文内推荐**
文章推荐：《Socratic-Zero》、《R-Zero》、《Absolute Zero》、《GRPO: Group Relative Policy Optimization》、《Qwen3 Technical Report》

**12.2 引申阅读**
引申阅读：《SAGE: Multi-Agent Self-Evolution for LLM Reasoning》、《Learning to Self-Evolve (LSE)》、《ReAct: Synergizing Reasoning and Acting in Language Models》、《ToolFormer: Language Models Can Teach Themselves to Use Tools》、《WebRL: Training LLM Web Agents via Self-Evolving Online Curriculum》
