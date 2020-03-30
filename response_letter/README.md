# Response letter

Dear editor,

Thank you for the helpful comments on our manuscript. We have revised it accordingly. Below we provide a detailed response to each of these comments. We hope it is now suitable for publication in Methods in Ecology and Evolution.

Kind regards,

Richel Bilderbeek, Giovanni Laudanno and Rampal S. Etienne

## Feedback senior editor, Dr Lee Hsiang Liow

> I think that this ms is "in between" an Application ms and a full Research ms. 
> While the idea can be generally applied to phylogenetic inference, 
> your pirouette R package is associated with BEAST2. 
> I would suggest either writing it as a short Applications ms (3000 words)
> if you stick with the latter (and leave some programming details to 
> Supplementary Information or vignette in R or GitHub); OR expanding it to a 
> full Research ms but being more general and thorough with exploring the 
> interpretations and limitations of the approach (see reviewer 1 comments).

We agree. We shortened the main section of the manuscript to fit the 
Applications section. At the same time, the reviewers requested more detail,
so we added this, but moved it to the supplementary information.
 
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

Thanks, we have done so. See our responses to the detailed comments.

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

We have discussed these points in a new section 
called 'Guidelines for empiricists', 
in the supplementary information. 
Also, we have added examples to the supplementary information 
for (1) trees with
an increasing number of tips (section 'The effect of the number of taxa'), 
(2) alignments of different sequence 
lengths (section 'The effect of DNA sequence length').

> * 2) Related to the topic above, a discussion of what might be the effect 
  of non-clock like models of DNA evolution on the measured error (in 
  contrast with the clock like presented in the paper) might also be 
  interesting for the empiricist.

Agreed. We added this to the supplementary materials as well, 
in the subsection 'The effect of non-clock like models'.
 
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
>   Bayesian framework.” In real life the utility of pirouette will be 
>   associated with the “non-standard” tree priors from which we suspect (and 
>   hence know them) might affect our inferences. Hence illustrating its 
>   utility with an already “known” “non-standard” tree prior might be more 
>   effective.

We agree. We rewrote the initial non-standard tree to resemble a 
diversity-dependent tree (from Etienne et al., 2012), 
with a strong decrease in speciation rates, using the DDD package (as 
introduced in Etienne et al., 2012).

> * 4) On lines 174-175, briefly explain what is the nLTT statistic.

We have done so.

> * 5) Figure 5: the default plot setting results on the scale being plotted 
>   over the lower branch. This should be changed, or at least the figure 
>   should be fixed to help the reader. In fact in figure 2 this overlap 
>   did not happen...

We agree it looked clumsy. With the new setup, this figure is drawn well.

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

Thanks for these comments. 

To address this, we have changed the main example's tree 
to be a tree generated by the diversity-dependent birth-death model (Etienne et al. 2012). 

If the characteristics of the generating process can be grasped by the
current standard available tree prior, the development of a new BEAST2 tree
prior is not required. If, on the contrary, pirouette returns a substantially
different pair of true-twin distributions, it means that a tree prior
needs to be implemented for the new diversification model, if one deems this model to be applicable to real systems.

Now, the main example shows that current standard tree priors 
are mediocre in recovering the diversity-dependent tree, making the case for adding a diversity-dependent tree
prior to one's favorite phylogenetic tool.

Additionally, we have added another example to demonstrate the 
usefulness of pirouette, by making it show 
underparameterization (similar to Sarver et al., 2019, 'The choice of tree 
prior and molecular clock does not substantially affect phylogenetic 
inferences of diversification rates');
that is, we simulated a tree using a standard birth-death model, yet assumed the simpler
Yule model. Results are in section 'The effect of assuming a Yule tree prior on 
a BD tree'.

> * 1. As an initial remark, I imagine the models pirouette support have all 
>      been implemented in tested in other packages like geiger, ape, etc.? 
>      It might be interesting to list where the tree models are coming from, 
>      maybe merging Table 1 with section 6. If such models were implemented 
>      from scratch, there must evidence that they're working as intended.

Your assumption is correct: the tree models used in the Bayesian inference 
are all standard BEAST2 tree models. The phylogenies used in this manuscript
are from the DDD [Etienne et al., 2011] and TESS [Höhna et al., 2016b] R packages.
We reported in the manuscript that the TESS package is used to simulate
twin trees. The DDD package, instead, is used to show the impact on trees produced
by a non-standard tree prior.

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

We fully agree! Sometimes a non-standard tree prior is interesting, even with a
considerable error and we already argued that this finding 
suggests that a non-standard tree prior is turned into a standard one.
We have added a paragraph to make this more explicit.

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
was not discussed. We have added a discussion on this.

> * 4. Please correct me if I am wrong, but to run pirouette, I must have a 
>   working simulator of my new model. Is this not a quarter or a third of 
>   the way toward having an implementation of the tree model already? 
>   Arguably it is easier to implement simulators then likelihoods, but they 
>   often share the same engines (e.g., in order to simulate/stochastically 
>   map characters under an SSE model, one uses very similar ODE's - see 
>   Freyman & Höhna 2018 for an example). Does this requirement of pirouette 
>   not defeat the tool’s purpose? But maybe I misunderstand.

Yes, indeed, a simulation routine is needed to provide pirouette with the right 
input (i.e. a sufficient number of trees simulated under the same rules). 
We agree that although there are sometimes ways to perform inference based 
on the simulation algorithm (e.g. Freyman & Höhna 2018; Richter et al. 2020), these methods still require deriving and solving a set of ordinary differential equations or are extremely computationally demanding to sample the high-dimensional tree properly.

pirouette only requires the new model to be simulated, which is usually very straightforward.

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

Thanks for pointing out this point of confusion! 

We have rewritten the text to improve the clarity in the points 
mentioned. Special attention was given to the word 'generative': we
write about 'a generative tree model' (the model that generated the 
'true' phylogeny, which can by any novel model),
as well as make a clear distinction with 'the generative model assumed' in inference (which
is always a standard tree prior).

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

We agree on this point and we have added examples with replicates
to the supplementary materials. In response to other comments 
we have used a diversity-dependent
process to generate the true tree. 

### Reviewer: 2

> Comments to the Corresponding Author
> Pirouette is a great tool for judging whether new models are new enough to 
> be worth the effort of implementing in phylogenetic packages. Having a tool
> available to automate the workflow instead of having to cobble together some
> scripts to do this is a good idea.

Thank you for these kind comments.

> The manuscript can benefit from a bit of reorganisation, since initially it 
> was not clear to me that this is the main function of pirouette -- I confused 
> it with posterior predictive analysis, which seems to be closely related. 
> Perhaps the confusion stems from the fact that section 2 and 
> especially 2.2 dive into the practicalities before explaining the theory and
> motivation for someone wanting to do so. If that can be remedied it might
> prevent such confusion.

Indeed (and the other reviewer thought so as well), the manuscript needed
some reordering. We did so. We think it is a great improvement.

> * 1. line 20-22: "An open question is, how accurate the tree estimation is 
>   when the real macroevolutionary processes are substantially different from 
>   those assumed in the tree prior." which can be answered using tree model 
>   adequacy (TMA package for BEAST 2). Some context to clarify how this 
>   differs from posterior predictive analysis would be good here.

Indeed, TMA attempts to answer the same question, therefore we replaced 'an open question'
by 'a question'. In the discussion, we mention the similarities and differences with TMA.
We think it would be interesting to compare our results with those
when using TMA, but this is beyond the scope of the current ms.. 

> * 2. In general, the difference between the pirouette approach and 
>   TMA/posterior predictive method should be explained more clearly, since 
>   it mostly seems to be the starting tree being from a different source, 
>   and in tree statistics used. The twin phylogeny approach is a nice 
>   addition to posterior predictive analysis.

We put this in the discussion. We were in doubt to mention TMA in the 
Introduction, as TMA tries to answer the same question in a different way.
We felt, however, that the paper is not a good place for a detailed 
comparison between the two methods.

> * 3. line 53-62 please break up sentence -- this one is really hard to follow.

Definitely agree! We have done so.

> * 4. line 82ff: "Also recently, Duchêne et al. [Duchêne et al. 2018] 
>   released a BEAST2 package to assess how well posterior predictive 
>   simulations recover a given tree when using the standard diversification 
>   models. These studies show how current diversification models compare to 
>   one another, but they do not help to assess the importance of a new tree 
>   prior." This misrepresents the work of Duchêne et al, which aims to 
>   demonstrate that a tree prior is *adequate* (the package is called TMA = 
>   tree model adequacy), which is pretty much the aim of this paper.

Agreed. This was a major blunder [1]! We gave the 2018 paper the more rightful
credit.

 * [1] I, RJCB, the author of that part, was probably confusing this work with Duchene 
   et al., 2014, 'The impact of calibration and clock-model choice on
   molecular estimates of divergence times' paper


> * 5. Table 1 why is order of abbreviation in legend different from the order 
>   of rows in the table?

We agree. Now all the elements in the last column of table 1 are
arranged alphabetically. The elements reported in the legend
are presented in the same order.

> * 6. Figure 1 "The twin alignment has the same number of mutations as the 
>   original alignment." and line 188ff: why keep the number of mutations 
>   constant? With the same root height and same mutation rate, there should 
>   be some natural variation in the number of mutations. Fixing these feels 
>   like this could cause unexpected biases, e.g., reduce the variance in the 
>   error measure for the twin tree analysis.

We agree with these concerns. 
To investigate if these concerns are warranted, 
we have added 'The effect of equal or equalized mutation rate
in the twin alignment'.
From the results presented in that section,
we can conclude that this indeed has an effect (in hindsight, using
the same mutation rate would have made our main text's example
more dramatic!), but we could not decide which approach of the two
is better. Therefore, we left things as they were.

> * 7. line 142 "nucleotide substitution model, which we will refer to as site 
>   models".
>
>   * 1. Site models include things like gamma rate heterogeneity and proportion 
>     invariable sites, so calling a substitution model a site model does 
>     not seem to be appropriate.

Thanks to point out our inappropriate choice of words.
We have reworded accordingly throughout the document.

>   * 2. Are gamma rate heterogeneity and proportion invariable sites supported?

Yes, they can indeed be specified in the inference model, as part 
of the (now awkwardly named) `create_site_model` function.

> * 8. line 146 where does the set of inference models come from?

Thanks, this set indeed appeared out of the blue! We have introduced
the set of inference models more gently, which are simply all standard 
inference models that are appropriate in their most basic form.

> * 9. If the inference model used in generating data differs from that 
>      inferring the tree, are you really testing the adequacy of the 
>      original model, or doing integration testing of the whole process? 
>      Using the same site and clock model used to generate the alignment 
>      seems to be the natural thing to do, since you are interested in the 
>      tree model, not the clock or site models.

Your suggestion is exactly what we do. After some more careful rewording
we hope we have made this clearer.

To answer the question: we think that 'doing integration 
testing of the whole process' is the better descriptor of the two. 
To be more precise, avoiding the term 'adequate',
we measure how well a standard tree prior can be used in the inference
of a phylogeny generated by a non-standard tree prior.

Again, we hope that our new choice of words helps in making this clearer.

> * 10. How to determine an appropriate length of the sequence? 
>   If the sequence is long enough, the site model model for inference will be 
>   the same as that for generating the alignment. Also, for sufficiently 
>   long sequences, the tree prior won't matter (as mentioned in the paper), 
>   so I suppose the sequences should not be too informative. Some discussion 
>   around these issues would be useful.

We have added your suggestion to the discussion and we agree with your predictions.
To test these, we added an example with different DNA sequence lengths to the
supplementary materials, section 'the effect of the DNA alignment sequence 
length'. These results are not conclusive, due to
the low number of replicates, but they hint that, as expected, longer
DNA sequences reduce the errors.

> * 11. The height of the tree in units of substitutions will be a factor: 
>   when the tree is small (<< 0.1 substitutions) sequences will have many 
>   constant sites, and the tree cannot be reliably recovered. 
>   When the tree is large (>>1 substitutions), there will be saturations and 
>   it will be impossible to recover the tree. In the example, 
>   a distance of 1 is used (tree height = 10, mutation rate = 0.1), 
>   but not explained why that is a good combination. 
>   Some discussion around this would be useful.

Definitely! We have added this, also as a worked example in the Appendix, 
section 'The effect of mutation rate'

> * 12. Isn't it more natural to define priors on parameters of the site 
>       model (in the spirit of https://github.com/rbouckaert/DeveloperManual/) 
>       instead of fixing them in the set I_1,...,I_N?

Thanks for this interesting reference, regarding the development
of new BEAST2 tree priors. The point of `pirouette`, however, is to 
measure *whether* we need to implement new BEAST2 tree priors.
We have rewritten this to make this clearer.

> * 13. line 174 The nLTT statistic is agnostic about taxa labels, as opposed 
>   to for example Robinson Foulds distance, and has only been demonstrated to 
>   be useful in an ABC setting. Please explain why this is such a good 
>   statistic instead of say tree length, gamma statistic, treeness, or any of 
>   the other tree metrics in the TreeStat2 package for BEAST 2.

We could have picked any method to quantify a difference
between two phylogenies. The advantage of the nLTT statistic is 
that it can compare any two phylogenies and its results are in a known 
range (that is, between zero and one). We added this explanation to the
manuscript. Yet again, the Robinson Foulds distance, tree length, 
gamma statistics and other would be good choices as well.

> * 14. Line 176 Instead of describing the mechanism for generating a twin 
>   tree, starting with motivation for why one wants to get involved with a 
>   twin tree would be good. This now only starts at line 186 and further.

Great idea! We have done so and think is is a great improvement.

> * 15. line 568: capitals are missing from the references "Bayesian" 
>   "nLTT", etc. You might want to check other references as well.

Well spotted! We have corrected this.

> Out of curiosity:
>
> * 16. Have you identified tree models that are sufficiently different to be 
>   worth implementing in BEAST?

Yes, we have, but we have not yet published this.

The question is not so much whether a new tree model yields a 
difference with a BEAST2
standard tree model, but for which parameter settings this starts to matter.
As an example, we used the protracted birth-death 
process [Etienne and Rosindell, 2012, 'Prolonging the past counteracts the 
pull of the present: protracted speciation can explain observed slowdowns 
in diversification'. Systematic Biology], 
based on the idea that speciation takes time. 
Without going into details of that model,
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

One can imagine that using a standard tree prior on this tree, will give a large
error. So, we predict the error can be very large for non-standard tree priors, 
but then the question arises whether this is a biologically realistic set of
parameters.

> * 17. Why was this implemented as R package instead of a BEAST package 
>   (similar to the TMA package) so it can benefit from all models available 
>   in BEAST, and not just a limited subset?

`pirouette` arose as a spin-off of a biological research project. 
We wanted to separate the re-usable part (`pirouette`) from the specific
experiment. This initial research project was in R, as
it was based on the R package `babette` [Bilderbeek & Etienne, 2018]. 
Due to this, `pirouette` ended up 
being written in R. One advantage of using R is that 
running the experiment and analysing it can be done in the same script.

A drawback of `babette`, indeed, is that it cannot provide for all BEAST2 
packages: it does have a BEAST2 package manager (called `mauricer`)
and it does allow using one BEAST2 package (NS, for 'Nested Sampling', a
method to estimate the marginal likelihood of an inference model).

All in all, putting `pirouette` into a BEAST2 package may have been an
equally fine option. It just did not happen that way.

