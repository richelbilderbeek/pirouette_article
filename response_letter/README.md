# Response letter

RJCB: after reading the feedback carefully, I see the following threats:

 * There is a conflict between (1) shortening the manuscript to be an
   Application article, and (2) explaining more details for empiricists.
   As a resolve, I suggest to move the details to a 'Guidelines for
   empiricists' section in the Appendix
 * There is a big overlap with the posterior predictive analysis of [1].
   As a resolve, I suggest to first try to demonstrate that `pirouette`
   can do the same analysis as [1] and more. If the analysis is indeed
   too different, focus on these differences more

For the rest, it is some work, but not AFAICS exhaustingly much.

 * [1] Duchene, Sebastian, et al. "Phylodynamic model adequacy using posterior 
   predictive simulations." Systematic biology 68.2 (2018): 358-364.

## Feedback senior editor, Dr Lee Hsiang Liow

> I think that this ms is "in between" an Application ms and a full Research ms. 
> While the idea can be generally applied to phylogenetic inference, 
> your piroutte R package is associated with BEAST2. 
> I would suggest either writing it as a short Applications ms (3000 words)
> if you stick with the latter (and leave some programming details to 
> Supplementary Information or vignette in R or github); OR expanding it to a 
> full Research ms but being more general and thorough with exploring the 
> interpretations and limitations of the approach (see reviewer 1 comments).

We agree. We chose to shorten the main section of the manuscript to fit the 
Applications section. Due to this, the multiple comments by the reviewers to
discuss something in more detail, have been added, yet moved to the appendix.

 * [ ] Shorten to Application
 * [ ] Move empiricists' guidelines to Appendix
 
## Comments to the Author:

> This is an interesting paper which introduces an R package design to test 
> whether new tree prior are “relevant” enough to justify the effort to 
> implement such new species tree prior. As said by one of the reviewers 
> “Having a tool available to automate the workflow instead of having to 
> cobble together some scripts to do this is a good idea”, but there are some 
> aspects that need a bit more clarification and perhaps additional work to 
> justify the publication of the method. I found the paper to be well 
> written (but see reviewer’s comments for some interesting ideas on how to 
> improve the paper flow), and the work potentially relevant, but as mentioned 
> above I agree with the reviewers that there are a some 
> clarifications/adjustments that need to be made before the we can properly 
> evaluate the paper.

Thanks, we will happily do so.

> Apart from what was mentioned by both reviewers I would add (some purely 
> cosmetic) the following:
>
> * 1) I understand that the main goal of the paper was to introduce the 
> procedure and illustrate it with a simple example, but I felt it might be 
> interesting to discuss some aspects that empiricists might face when trying 
> to use this R package. This might help the reader to more probably engage 
> with the paper and the method to be better evaluated. For example, it might 
> be interesting to add in the discussion what are the author’s intuitions of 
> how the tree size might affect the error. Does error scale with tree size? 
> Or how sequence length might also affect error estimates (mentioned by one 
> of the reviewers).

We've discussed these points at a new 'Guidelines for empiricists' 
section in the appendix.

 * [ ] Discuss 'Does error scale with tree size?' in Appendix.
   Mention paper in which bigger trees increase error (Revell, Liam J., Luke J. 
   Harmon, and Richard E. Glor. "Under-parameterized model of sequence 
   evolution leads to bias in the estimation of diversification rates from 
   molecular phylogenies." Systematic Biology 54.6 (2005): 973-983)
 * [ ] Discuss 'How does sequence length affect the error?' in Appendix.

> * 2) Related to the topic above, a discussion of what might be the effect 
  of non-clock like models of DNA evolution on the measured error (in 
  contrast with the clock like presented in the paper) might also be 
  interesting for the empiricist.

Agreed. We added this.

 * [ ] Add this, mention nodeSub

> * 3) It might also be interesting to run an example of 
>   a “non-standard” tree prior which we think might be empirically
>   relevant (e.g. diversity dependence). The authors mention this but I felt 
>   that using a tree prior (which by the way does resemble diversity 
>   dependence - or at least a decrease in speciation- given that most splits 
>   are concentrated in the base of the tree) that is unknown might not be the 
>   best narrative choice. As mentioned by the authors in the 
>   introduction “Only new diversification models that result in a large 
>   discrepancy between inferred and simulated phylogenies will be worth the 
>   effort and computational burden to implement a species tree prior for in a 
>   Bayesian framework.” In real life the utility of pirouete will be 
>   associated with the “non-standard” tree priors from which we suspect (and 
>   hence know them) might affect our inferences. Hence illustrating its 
>   utility with an already “known” “non-standard” tree prior might be more 
>   effective.

Agreed, we rewrote the initial non-standard tree to resemble a 
diversity-dependent tree, with a strong decrease in speciation rates.

 * [ ] Add use of simulated DD tree in code
 * [ ] Add use of DD tree in text, with reference to Etienne & Haegeman, 2012

> * 4) On lines 174-175, briefly explain what is the nLTT statistic.

Agreed.

 * [ ] Do so, with reference to Janzen & Hoehna, ?2016

> * 5) Figure 5: the default plot setting results on the scale being plotted 
>   over the lower branch. This should be changed, or at least the figure 
>   should be fixed to help the reader. In fact in figure 2 this overlap 
>   did not happen...

We agree it looks clumsy and we wrote a script to pretty-print this figure.

Note that this cumbersome placement of the scale is default behavior of the 
package we use for plotting (`ape`), as is written in the manuscript.

 * [ ] Write script to generate figure 2 with a proper plot.

## Reviewer(s)' Comments to Author:

### Reviewer: 1

> Comments to the Corresponding Author
>
> In this paper, Bilderbeek and co-authors present “pirouette”, a tool 
> implemented in R for evaluating tree inference error due to tree prior 
> misspecification. The main task of pirouette is to quantitatively evaluate 
> the amount of tree inference error when data is generated under a “new” 
> tree model, but analyzed under another (true-and-tested) model - the 
> ultimate goal is to determine whether the new tree model is “worth the 
> effort and computational burden to implement [...] in a Bayesian 
> framework”. Pirouette works by first simulating data (sequence alignments) 
> along a tree generated under the new model, given a set of known 
> nucleotide evolution and clock models. Then it determines the baseline 
> error (due to the stochasticity of MCMC) through a process the authors 
> dubbed “twinning”, to which the “true” error (under a hand-picked or 
> best-fit tree model) is compared. Throughout the paper error is measured 
> with the nLTT statistic, though other statistics can be used.
>
> The paper is overall well written, with simple worked examples that are 
> easy to follow and in logical order. However, as is, this article reads 
> as a very pleasant tutorial that ultimately fails to justify the 
> usefulness of the pirouette tool. Here are some points in which this 
> study and its discussion could be improved.

...

[RJCB: here, the reviewer has a strong point: 'this article [..] fails to 
justify the usefulness of the [..] tool'.]

 * [ ] ...

> * 1. As an initial remark, I imagine the models pirouette support have all 
>      been implemented in tested in other packages like geiger, ape, etc.? 
>      It might be interesting to list where the tree models are coming from, 
>      maybe merging Table 1 with section 6. If such models were implemented 
>      from scratch, there must evidence that they're working as intended.

Your assumption is correct: the tree models used in the Bayesian inference 
are all standard BEAST2 tree models. The phylogenies used in this manuscript
are from the DDD [...] and ?TESS [...] R packages.
 
 * [ ] Add reference to DDD package here
 * [ ] Add reference to TESS package here

> * 2. Tree models are often used as priors in phylogenetic analyses whose main 
>      goal is to infer species tree topologies and divergence times. However, 
>      we are often interested in estimating the model parameters as they 
>      represent relevant biological quantities. For example, in the “SSE” 
>      family of models that the authors refer to in the introduction, there are 
>      specific diversification parameters that can teach us about how speciation 
>      takes place (e.g., in a trait-, or geographic-dependent manner). So 
>      regardless of the measured tree inference error when the tree prior is 
>      misspecified, it might still be worth implementing a new tree model. I 
>      would go even further and say that while in turns out that tree priors 
>      end up being commonly used in species tree inference, it is commonly the 
>      case that they are invented and implemented because researchers are 
>      interested in learning other evolutionary aspects from their favorite 
>      clades or species.

Agreed! Sometimes a non-standard tree prior is interesting, even with a
considerable error and we already agreed upon that this finding 
encourages to make that non-standard tree prior a standard one.
We have added a paragraph to express this more explicitly.

 * [ ] Add paragraph that states that a tree prior that produces big errors,
       may still be favored. Also recommend adding that tree prior to BEAST2
       exactly due to that.

> * 3. Let us say we run pirouette and observe something similar to Fig. 6. 
>   There is clearly an increase in tree inference error, but how much 
>   is “enough” so I can actually determine whether or not I want to implement 
>   my new model? The authors themselves highlight an important point in the 
>   introduction “(...) when the data are very informative, as this will 
>   reduce the influence of the tree prior”. Presumably, if I have a lot of 
>   data, then I should expect a small different between my twinning and 
>   true error to be alarming? Or did I misunderstand? And if this is 
>   correct, how much is a lot of data? How about hyper-prior 
>   misspecification? Does it matter? Should one worry about tree topology 
>   errors at all? None of these things are quantitatively (or qualitatively) 
>   addressed through the worked example and in the discussion. Bottom line is 
>   that I effectively would not know how to interpret my error distribution 
>   after using this tool, even after observing a difference between “twin” 
>   and “true”.

We agree that the interpretation of the error distributions 
is -sadly- still open to discussion. 

...

 * [ ] RJCB: Check: I think I mentioned this in the discussion

> * 4. Please correct me if I am wrong, but to run pirouette, I must have a 
>   working simulator of my new model. Is this not a quarter or a third of 
>   the way toward having an implementation of the tree model already? 
>   Arguably it is easier to implement simulators then likelihoods, but they 
>   often share the same engines (e.g., in order to simulate/stochastically 
>   map characters under an SSE model, one uses very similar ODE’s - see 
>   Freyman & Hohna 2018 for an example). Does this requirement of pirouette 
>   not defeat the tool’s purpose? But maybe I misunderstand.

Indeed, having a working simulator is indeed a good first step. 

 * [ ] Read Freyman & Hohna 2018 just to be sure, the reconsider this answer

> * 5. One thing that got me confused. In the last section, listing 13 sets 
>   the “twin_model” to “birth_death”, but then in both top and bottom panels 
>   of Fig. 6 we see either “Yule” or “CEP”. In the text, it says the tree 
>   came from a Yule-like process, which is why I assume the top panel 
>   has “Yule” in the legend. Is this a typo? I also do not understand why 
>   the top panel legends read “Generative”. If the purpose of pirouette is 
>   to evaluate whether or not I want to implement a new tree model, then it 
>   doesn’t make sense to already have it implemented the inferential part in 
>   R. When I read “generative” I immediately start to think that the true 
>   generative tree model was used in inference, but I think what the authors 
>   mean here is everything else in the whole model stayed the same, but Yule 
>   was used as the tree prior. Am I correct in assuming this? If so, I would 
>   re-label this graph. In fact, this section could use a bit of rewriting 
>   to clarify this point regardless of my correct understanding.

Thanks for pointing out this point of confusion. We've rewritten the text with
the goal of improving the clarity in the points mentioned.

 * [ ] Improve definition of generative model
 * [ ] Rewrite sections indicated with focus on removing this confusion

> * 6. My final point that would require some more work is in fact noted by 
>   the authors themselves, namely that “one tree is not enough to determine 
>   the impact of a tree prior on Bayesian inference”. Indeed, I would like 
>   to see not only the error distribution better characterized in terms of 
>   their relative magnitudes (as mentioned in my second point above), but 
>   also in terms of distributions of simulated trees. It is fine to have 
>   simple worked examples around a single tree - as they provide a clear axis 
>   along which to explain the workings of a program - but in a real-world 
>   scenario, one would probably have a distribution of trees in hand. What 
>   if the worked example in this paper revolves around a tree that is at 
>   the “tail” of the tree distribution produced by the new tree model? 
>   Perhaps if another tree was picked, then the twin and true error 
>   distributions could look more alike? Or be further apart?

We agree on this point and we implemented this in the manuscript.
Because -due feedback from the other reviewer- we use a diversity-dependent
process to generate the true tree. Because the likelihood of these trees
are known, we'll show the pirouette results for diversity-dependent trees 
with low, medium and high likelihood.

 * [ ] Add `pirouette` results for DD trees with low, medium and high likelihood
 * [ ] Describe this in text

### Reviewer: 2

> Comments to the Corresponding Author
> Pirouette is a great tool for judging whether new models are new enough to 
> be worth the effort of implementing in phylogenetic packages. Having a tool
> available to automate the workflow instead of having to cobble together some
> scripts to do this is a good idea.

Thanks!

> The manuscript can benefit from a bit of reorganisation, since initially it 
> was not clear to me that this is the main function of pirouette -- I confused 
> it with posterior predictive analysis, which seems to be closely related. 
> Perhaps the confusion stems from the fact that section 2 and 
> especially 2.2 dive into the practicalities before explaining the theory and
> motivation for someone wanting to do so. If that can be remedied it might
> prevent such confusion.

Indeed, the posterior predictive analysis from Duchene et al, 2018 is very 
similar. 

[RJCB: I would guess this type of analysis can be done by pirouette as well;
pirouette does the same as Duchene et al., 2018 and more. If so, this
makes a stronger case for pirouette]

 * [ ] Check this
 * [ ] If true, add to text

> * 1. line 20-22: "An open question is, how accurate the tree estimation is 
>   when the real macroevolutionary processes are substantially different from 
>   those assumed in the tree prior." which can be answered using tree model 
>   adequacy (TMA package for BEAST 2). Some context to clarify how this 
>   differs from posterior predictive analysis would be good here.

Agreed.

> * 2. In general, the difference between the pirouette approach and 
>   TMA/posterior predictive method should be explained more clearly, since 
>   it mostly seems to be the starting tree being from a different source, 
>   and in tree statistics used. The twin phylogeny approach is a nice 
>   addition to posterior predictive analysis.

Agreed!

> * 3. line 53-62 please break up sentence -- this one is really hard to follow.
>
> * 4. line 82ff: "Also recently, Duchene et al. [Duchene et al. 2018] 
>   released a BEAST2 package to assess how well posterior predictive 
>   simulations recover a given tree when using the standard diversification 
>   models. These studies show how current diversification models compare to 
>   one another, but they do not help to assess the importance of a new tree 
>   prior." This misrepresents the work of Duchene et al, which aims to 
>   demonstrate that a tree prior is *adequate* (the package is called TMA = 
>   tree model adequacy), which is pretty much the aim of this paper.

Blimey, thanks for re-directing us to this paper, which indeed is
very similar to what `pirouette` does.

[RJCB: I guess I wrote that blunder. I must have been confused with the 
Duchene et al., 2014 paper?]

 * [ ] RJCB: check article again

> * 5. Table 1 why is order of abbreviation in legend different from the order 
>   of rows in the table?

Agreed, we should have sorted the same way in both cases. 
We changed this to sorting alphabetically 

[RJCB: alternative is ordering by model complexity].

 * [ ] Sort values alphabetically 

> * 6. Figure 1 "The twin alignment has the same number of mutations as the 
>   original alignment." and line 188ff: why keep the number of mutations 
>   constant? With the same root height and same mutation rate, there should 
>   be some natural variation in the number of mutations. Fixing these feels 
>   like this could cause unexpected biases, e.g., reduce the variance in the 
>   error measure for the twin tree analysis.

Well spotted! We keep the number of mutations constant to keep the amount
of genetic information between true and twin tree identical. 

[RJCB: I've added an example,
https://github.com/richelbilderbeek/pirouette_example_18
that simulates a twin alignment with the same mutation rate
as a setting that uses a twin alignment with the same number
of mutations,
https://github.com/richelbilderbeek/pirouette_example_3]

 * [ ] Mention the consequences of this choice, like the reviewer did

> * 7. line 142 "nucleotide substitution model, which we will refer to as site 
>   models".
>
>   * 1. Site models include things like gamma rate heterogeneity and proportion invariable sites, so calling a substitution model a site model does not seem to be appropriate.

Thanks correcting us on our sloppy wording. We have reworded accordingly.

 * [ ] Reword accordingly

>   * 2. Are gamma rate heterogeneity and proportion invariable sites supported?

Yes, they can ideed be specified in the inference model, as part 
of the `create_site_model` function.

> * 8. line 146 where does the set of inference models come from?

Thanks, this set indeed appeared out of the blue! It is the set of inference
models of interest [RJCB: improve]

[RJCB: maybe this will be cut out anyways, due to shortening]

 * [ ] Improve

> * 9. If the inference model used in generating data differs from that 
>      inferring the tree, are you really testing the adequacy of the 
>      original model, or doing integration testing of the whole process? 
>      Using the same site and clock model used to generate the alignment 
>      seems to be the natural thing to do, since you are interested in the 
>      tree model, not the clock or site models.

Completely agree! And this is indeed exactly what we do! We've mentioned this
more explicitly in the text.

 * [ ] Do so

> * 10. How to determine an appropriate length of the sequence? 
>   If the sequence is long enough, the site model model for inference will be 
>   the same as that for generating the alignment. Also, for sufficiently 
>   long sequences, the tree prior won't matter (as mentioned in the paper), 
>   so I suppose the sequences should not be too informative. Some discussion 
>   around these issues would be useful.

[RJCB: I am unsure if a very long alignment will indeed decrease the
error, I've added a pirouette example 19 for this]

 * [ ] Refer to [1, 2]


 * [1] Sarver, Brice AJ, et al. "The choice of tree prior and molecular clock does not substantially affect phylogenetic inferences of diversification rates." PeerJ 7 (2019): e6334.
 * [2] Wertheim, Joel O., and Michael J. Sanderson. "Estimating diversification rates: how useful are divergence times?." Evolution: International Journal of Organic Evolution 65.2 (2011): 309-320.

> * 11. The height of the tree in units of substitutions will be a factor: 
>   when the tree is small (<< 0.1 substitutions) sequences will have many 
>   constant sites, and the tree cannot be reliably recovered. 
>   When the tree is large (>>1 substitutions), there will be saturations and 
>   it will be impossible to recover the tree. In the example, 
>   a distance of 1 is used (tree height = 10, mutation rate = 0.1), 
>   but not explained why that is a good combination. 
>   Some discussion around this would be useful.

Definitely! We've added this

 * [ ] Add, also reference to literature

> * 12. Isn't it more natural to define priors on parameters of the site 
>       model (in the spirit of https://github.com/rbouckaert/DeveloperManual/) 
>       instead of fixing them in the set I_1,...,I_N?

...

[RJCB: the reference is incredibly helpful! It only exists since September 2019,
has 3 contributors and 2 other people that starred it]

 * [ ] Reread https://github.com/rbouckaert/DeveloperManual, add wisdom  
       gained to manuscript

> * 13. line 174 The nLTT statistic is agnostic about taxa labels, as opposed 
>   to for example Robinson Foulds distance, and has only been demonstrated to 
>   be useful in an ABC setting. Please explain why this is such a good 
>   statistic instead of say tree length, gamma statistic, treeness, or any of 
>   the other tree metrics in the TreeStat2 package for BEAST 2.

We could have picked any method to quantify a difference
between two phylogenies. The nLTT statistic is just one of the many options
and simply happens to be our personal favorite.
The Robinson Foulds distance would be just as fine.

> * 14. Line 176 Instead of describing the mechanism for generating a twin 
>   tree, starting with motivation for why one wants to get involved with a 
>   twin tree would be good. This now only starts at line 186 and further.

Agreed.

 * [ ] Reword as such

> * 15. line 568: capitals are missing from the references "bayesian" 
>   "nltt", etc. You might want to check other references as well.

Thanks for pointing this out!

 * [ ] Check

> Out of curiosity:
>
> * 16. Have you identified tree models that are sufficiently different to be 
>   worth implementing in BEAST?

Yes, we do. Question is not if a tree model can give difference with a BEAST2
standard tree model, but for which parameter settings this starts to matter.
As an example, we'll use the protracted birth-death 
process [Etienne et al., ?2012]. Without going into details of that model,
if speciation takes a very long time, species trees will be obtained with
nodes close to the root:

```
    +---------------- A
  +-+
  | +---------------- B
  |  +--------------- C
 -+--+
     +--------------- D
```

One can imagine that using a standard tree prior on this tree, will give a big
error. So, we predict the error can be big for non-standard tree priors, which
gives rise to question of if this is a biologically realistic set of
parameters.

> * 17. Why was this implemented as R package instead of a BEAST package 
>   (similar to the TMA package) so it can benefit from all models available 
>   in BEAST, and not just a limited subset?

`pirouette` arose as a spin-off of a biological research project. 
We thought it a
good idea to seperate the re-usable part (`pirouette`) from the specifics.
Because the initial research project was in R, `pirouette` ended up being in R.

To go back in time a bit more, `pirouette` builds on 
`babette` [Bilderbeek & Etienne, 2018], 
an R package to call BEAST2, which was the first spin-off of that same 
biological research project.

A drawback of `babette`, indeed, is that it can not provide for all BEAST2 
packages: it does have a BEAST2 package manager (called `mauricer`)
and it does allow using one BEAST2 package (NS, for 'Nested Sampling', a
method to estimate the marginal likelihood of an inference model).
This BEAST2 package is used by `pirouette`, but not described in the article.

All in all, putting `pirouette` into a BEAST package may have been an
equally fine option. It just did not happen that way.
