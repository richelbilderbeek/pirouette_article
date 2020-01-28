# Response letter

TODO:

 * RSE: Write it as if you have already done the work


RJCB: after reading the feedback carefully, also from Gio, 
I see the following threats:

 * There is a conflict between (1) shortening the manuscript to be an
   Application article, and (2) explaining more details for empiricists.
   As a resolve, I suggest to move the details to a 'Guidelines for
   empiricists' section in the Appendix
 * There is an overlap with the posterior predictive analysis ('PPA') of [1].
   I feel `pirouette` cannot do this. We need to highlight the overlap
   and difference with PPA.
 * There is a conflict about the target audience of `pirouette`, which
   can be (1) theoreticians, and (2) empiricists. As a resolve, after
   shortening the manuscript to an Application article, we'll add the
   suggested worked out examples in the Appendix

For the rest, it is some work, that will fit in only if prioritized.

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
Applications section. At the same time, the reviewers requested more detail, 
so we add this, but moved it to the supplementary information.

 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/74: Shorten to Application
 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/72: Use only one example
 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/73: Move empiricists' guidelines, 'step by step and long explanation', 
       to Appendix, 
 * [ ] Ask Rampal's idea: what *is* an empiricist in the context of pirouette?
       [RSE: The empiricist wants to be sure his/her phylogeny is close to the 
       truth. If he/she feels that a certain diversification process is 
       important for their group, then he/she would like to know how important 
       this is for tree inference. Pirouette will give the answer if this 
       diversification process can be simulated]
 * [ ] Richel: think about 'Should/could empiricists use pirouette?'
 
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

Thanks, we have done so.

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

We have discussed these points in a new section called 'Guidelines for empiricists', 
in the supplementary information [RSE: I bet the editor wants to see 
this in the main text.]. Also, we have added a worked example for (1) trees with
an increasing number of tips (section 'The effect of the number of taxa'), 
(2) alignments of different sequence lengths (section 'The effect of DNA sequence length')

 * [X] https://github.com/richelbilderbeek/pirouette_article/issues/55: 
   Write script that shows the true and twin error for 
   a fixed tree prior and reasonably small trees
   (say in the magnitudes of hundreds of them)
   with 10:40 taxa at https://github.com/richelbilderbeek/pirouette_example_20
 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/63:
   Interpret and improve subsection 'The effect of the number of taxa';
   Add a worked example that shows the error for 10,20, ..., 100/?1000 tips
 * [R] https://github.com/richelbilderbeek/pirouette_article/issues/77:
   Add literature to section 'Does error scale with tree size?' in Appendix.
   Mention paper in which bigger trees increase error (Revell, Liam J., Luke J. 
   Harmon, and Richard E. Glor. "Under-parameterized model of sequence 
   evolution leads to bias in the estimation of diversification rates from 
   molecular phylogenies." Systematic Biology 54.6 (2005): 973-983) 
 * [X] https://github.com/richelbilderbeek/pirouette_article/issues/56: 
   Write script that shows the true and twin error for 
   hundreds of trees with 10, 1k, 2k, ..., 10k nucleotides at 
   https://github.com/richelbilderbeek/pirouette_example_21
 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/64:
   Interpret and improve subsection 'The effect of DNA sequence length'
   Add a worked example that shows the error for alignments of
   100, 1k, 2k, ..., 10k nucleotides. 

> * 2) Related to the topic above, a discussion of what might be the effect 
  of non-clock like models of DNA evolution on the measured error (in 
  contrast with the clock like presented in the paper) might also be 
  interesting for the empiricist.

Agreed. We added this, also as a worked examples (section 'The effect of 
non-clock like models')

 * [X] Add nodeSub worked example (pirouette_example_17)
 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/65:
   Interpret and improve subsection 'The effect of non-clock like models';
   Add nodeSub working example to text
 
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

We agree. We rewrote the initial non-standard tree to resemble a 
diversity-dependent tree (from Etienne et al., 2011), 
with a strong decrease in speciation rates, using the DDD package (as 
introducted in Etienne et al., 2011).

 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/75:
   Pick a DD tree for our main example
 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/78:
   Use nice DD tree in main text's example code
 * [X] https://github.com/richelbilderbeek/pirouette_article/issues/79:
   Describe DD in text, with reference to Etienne and Haegeman, 2012

> * 4) On lines 174-175, briefly explain what is the nLTT statistic.

We have done so.

 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/80:
   Describe nLTT statistic in main text, with reference to Janzen & Hoehna, ?2016

> * 5) Figure 5: the default plot setting results on the scale being plotted 
>   over the lower branch. This should be changed, or at least the figure 
>   should be fixed to help the reader. In fact in figure 2 this overlap 
>   did not happen...

We agree it looks clumsy and we wrote a script to pretty-print this figure.

Note that this cumbersome placement of the scale is default behavior of the 
package we use for plotting (`ape`), as is written in the manuscript.

 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/76:
   Write script to generate figure 2 with a proper plot.

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

Thanks for these comments. We have added a worked example demonstrating the 
usefulness of pirouette (section 'The effect of assuming a Yule tree prior on 
a BD tree') [RSE: Add the text that you add to the ms also here in 
the response letter. Do this for all additions (unless really minor)].

 * [ ] Add Gio's text to the manuscript
 * [X] https://github.com/richelbilderbeek/pirouette_example_26:
   Add script that shows the true and twin error for a BD tree when 
   assuming a Yule tree prior.
 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/67:
   Interpret and improve subsection 'The effect of assuming a Yule tree prior 
   on a BD tree'

GL: The easiest way to address this criticism (and point 3 from previous list) 
is to add in the appendix a clear example with two different runs:
in the first one we use a generative model 
that's close to the candidates (e.g. yule); in the second one we use something
very different (DDD, as mentioned before is a good idea, but also PBD, MBD, 
-SSE etc could be used, in principle). The aim is to maximize the
divergence in outputs in order to prove our point, which should be
something like this:
"If the characteristics of the generating process can be grasped by the
current standard available tree prior the development of a new BEAST2 tree
prior is not required. If, on the contrary, pirouette returns a significantly
different pair of true-twin distributions, it means that a new tree prior
needs to be implemented. We show this with the following/previous worked example."
[...] If we implement a metric, say Jensen-Shannon divergence, we can
easily use it to show numerically that they differ.

 * [ ] Prove our point
 * [X] https://github.com/richelbilderbeek/pirouette_article/issues/57: 
   Write script that shows the true and twin error for Yule
   tree and Yule tree prior at 
   https://github.com/richelbilderbeek/pirouette_example_22
 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/66:
   Add worked example with standard tree model and correct tree 
   prior (Yule tree and Yule tree prior), section 'The effect of assuming 
   a Yule tree prior on a Yule tree'

> * 1. As an initial remark, I imagine the models pirouette support have all 
>      been implemented in tested in other packages like geiger, ape, etc.? 
>      It might be interesting to list where the tree models are coming from, 
>      maybe merging Table 1 with section 6. If such models were implemented 
>      from scratch, there must evidence that they're working as intended.

Your assumption is correct: the tree models used in the Bayesian inference 
are all standard BEAST2 tree models. The phylogenies used in this manuscript
are from the DDD [...] and ?TESS [...] R packages.
 
 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/81:
   Add reference to DDD package here
 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/82:
   Add reference to TESS package here

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
We have added a paragraph to express this more explicitly.

 * [ ] Add paragraph that states that a tree prior that produces big errors,
   may still be favored. Also recommend adding that tree prior to BEAST2
   exactly due to that.
       
GL: We might also add that sometimes it's possible to write simulation codes for
specific kind of diversification processes (e.g. all the new simulations that
are currently under development in the DAISIE framework, like including
island ontogeny (pedro and josh) or traits (shu) or many many others) whereas it
is not possible to provide an equivalent likelihood for the process.
As a matter of fact there are many more models that could be simulated than
the ones for which a likelihood could be defined.
In those case one could desire to assess the error made by inferring with the best
available likelihood (aka tree prior), even though it is clearly not the
one perfectly tailored on the problem (as it is actually not available).
This could actually turn to be quite usefull for all those cases, hopefully.

RJCB: Agreed, but unsure if this is the reviewer's point

GL: Mmm, even though what I wrote could be of some utility
in favor of pirouette's capabilities, I think you are
right that this is not the reviewer's point.
So I'll try again. 

[GL: AFAICS they're talking about the fact
that you might be interested in estimating some parameters from
an alignment. This can be done using BEAST2 exploiting its
function to estimate parameter posteriors along with tree
posteriors. My doubt is: many times I've seen people
(Rampal in primis: e.g. DDD, DAISIE, PBD articles)
estimating parameters with some likelihood models
starting directly from a tree. Phylogenies do not exist
in nature, therefore such trees have to come from
some BEAST inference obtained using some tree prior, probably
a birth-death prior. So, if you can clearly do it also in
this way, why would people desire to start from alignment
(which will require to implement the tree prior in beast)
to estimate parameters? I am a bit puzzled.

RJCB: I think the reviewer's point is, that even if pirouette gives a big
difference between twin and true error distribution, one may still choose
to use the model that generated the true tree. I agree with the reviewer.
Regarding your point 'if you can clearly do it also [by using trees], 
why would people desire to start from alignment [...] to estimate parameters?',
I agree: a tree is a cleaner type of data then an alignment. I just don't think
this is the point the reviewer makes here.

[RSE: I agree with Richel that the reviewer just argues that we may want to 
implement a non-standard tree prior to know more about biologically 
meaningful parameter estimates. The reviewer just asks us to acknowledge this.]

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

[RJCB: Unsure if we keep them in, just briefly explore for now]

 * [ ] Mention Jensen-Shannon divergence implementation in RPANDA
 * [ ] Mention other error statistics: Robinson-Foulds distance (Robinson and 
       Foulds 1981), nearest neighbor interchange (Moore et al. 1973),
       'define polytopic contours around a reconstructed tree in order to define 
       'confidence regions' in the tree (Billera et al. 2001)' and the ones 
       Thijs Janzen added to nodeSub

[RSE: I don’t think doing these statistics will help. Testing for significance 
is not relevant, when we can simply increase the sample size. We are 
interested in the effect size. But ultimately it is up to the user whether he 
or she is alarmed by a difference in errors. When the ratio of these errors 
is 1.1, I would not be alarmed, but when it is 2, then I start to get worried. 
At the same time, you could argue that only the absolute error matters: the 
deviation from the true tree. I think that adding a discussion paragraph along 
these lines may be sufficient.]

GL: [Josh] wanted to apply [a method from Kumar & Hunter]
to measure tree discrepancies (like nLTT, but a bit more sophisticated,
taken from "Lewitus & Morlon (2016): Characterizing and Comparing Phylogenies
from their Laplacian Spectrum").

RJCB: I think you are suggestion a new error statistic here, which
I think is fun and even already may be in the nodeSub package. 
I think this is something different, however, than the point of
the reviewer, which is about the interpretation of the error distributions.

> * 4. Please correct me if I am wrong, but to run pirouette, I must have a 
>   working simulator of my new model. Is this not a quarter or a third of 
>   the way toward having an implementation of the tree model already? 
>   Arguably it is easier to implement simulators then likelihoods, but they 
>   often share the same engines (e.g., in order to simulate/stochastically 
>   map characters under an SSE model, one uses very similar ODE’s - see 
>   Freyman & Hohna 2018 for an example). Does this requirement of pirouette 
>   not defeat the tool’s purpose? But maybe I misunderstand.

Yes, indeed, a simulation routine is needed to provide pirouette with the right 
input (i.e. a sufficient number of trees simulated under the same rules). 
However, even though simulation algorithms and
likelihood formulas often share the same engines, their respective implementations
might entail very different degrees of efforts.

[RSE: Don’t use examples that have not been published. I think the reviewer 
wants the paper Freyman & Hoehna to be cited. I think we can cite it to say: 
Although there are sometimes ways to perform inference based on the simulation 
algorithm (e.g. Freyman & Hoehna 2018), inference in general and computing 
tree priors in particular are computationally demanding if not impossible.]

In this sense, pirouette
proves to be a useful tool in providing numerical evidence for the sufficiency
of the sole simulation algorithm whereas a likelihood is actually not available
(i.e. in case true and twin distributions are similar enough).


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

We agree on this point and we have added a worked example in the 
manuscript. In response to other comments we have used a diversity-dependent
process to generate the true tree. Because the likelihood of these trees
are known, we show the pirouette results for diversity-dependent trees 
with low, medium and high likelihood (section 'The effect of differently 
common diversity-dependent trees'). [RSE: Provide the frequency distribution 
of the likelihoods of all the trees that you have generated from which you 
picked the three trees. You can indicate these trees in the plot.]

 * [X] https://github.com/richelbilderbeek/pirouette_article/issues/58: 
   Write script that shows the true and twin errors for DD
   trees of different likelihoods, using a BD tree prior,
   https://github.com/richelbilderbeek/pirouette_example_23
 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/68:
   Interpret and improve subsection 'The effect of differently 
   common diversity-dependent trees'; add `pirouette` results for DD trees 
   with low, medium and high likelihood
 * [ ] Describe this in text
 * [X] https://github.com/richelbilderbeek/pirouette_article/issues/60: 
   Add `pir_runs` function that works on a distribution/list of trees

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

Indeed, the posterior predictive analysis from Duchene et al, 2018 bears some 
resemblance to what pirouette does, but there are important differences, most 
notably that we work with a tree generated by a non-standard tree prior, 
whereas Duchene et al start with an empirical tree. We have described the 
overlap and differences in the manuscript.

 * [ ] Describe overlap and differences with Duchene et al., 2018 in the manuscript
 * [ ] Reword Gio's synopsis below for reviewer

[GL: It does look similar but it's not the same. This is what I understood
(which is summarized also in figure 1 of the article): 
1) They start from an empirical tree, then they use BEAST to infer a 
posterior distribution of some parameters, given a model M, 
e.g. growth rate or population size;
2) They sample from this distribution to simulate a distribution of trees,
which they call (cryptically) "posterior predictive simulations" (PPS);
3) They use some summary statistics to compare this simulated distribution
of trees with the original tree.
Similarities (+) and differences (-) between Duchene (a) and pirouette (b):
PIPELINE:
+) Their pipeline is similar to our left column in our figure 1. It is, though,
not clear to me how they go from an empirical tree to a Beast posterior
because, AFAIK, Beast operates from alignment to a posterior.
TWINNING:
+) There is a similarity with the twinning:
   a) Their method infers parameters with beast and then simulates.
   b) Twinning infers parameters using maximum likelihood and then simulates.
-) There is also a big difference with twinning:
   a) This pseudotwinning yield the distribution to compare with the original tree.
   b) Twin tree is just the starting point for a new pipeline.
SUMMARY STATISTICS:
+) We both use some summary statistics to compare an original tree to a result
obtained from the inference.
GOALS:
-) We do not use an empirical tree but trees simulated according to some
diversification model. This is reflected in a difference in our goals:
   a) Their goal is to see if the process they use to simulate the PPS 
   can recover features of the original data, according to the chosen 
   summary statistics. Eventually they can choose which process yield
   the smallest difference according to the statistics.
   b) Our goal is to see if BEAST tree priors can recover the features
   of the diversification model that generated the original trees.
INFERENCE MODEL AND MODEL SELECTION:
-) The selection of the inference model is made in a different way:
   a) Their method tests all models and infers parameters for each of them using beast.
   Then it uses such parameters to simulate PPS for each model. Instead of a
   stricto sensu model selection they evaluate a posteriori whether each model
   is "adequate" using an equivalent of a P-valuecoming from the "posterior 
   predictive probability" (PPP) obtained from tree statistics.
   Their model evaluation is therefore operated a posteriori.
   b) Our method uses model selection before creating a posterior distribution. After that one
   could virtually use all the summary statistics he/she wants.
   Their model "selection" relies on the summary statistics. A multivariate
   assessment might be done in principle, but they stress that 
   they prefer "considering each test statistically separately"
   as Gelman et al. (2014) suggests.

GL: I [...] agree that [pirouette could have more functionality added], 
such as providing a baseline
error and pre-calculate model selection. Moreover, as I mentioned before,
pirouette actually performs a different task, as the original scope
of pirouette is to evaluate the goodness of the inference on trees generated
by a specific generative tree model. The stress, in our case, is on
the generative tree model, not on the empirical data. For this reason I believe our
tool is to address more to theoreticians than empiricists.]

> * 1. line 20-22: "An open question is, how accurate the tree estimation is 
>   when the real macroevolutionary processes are substantially different from 
>   those assumed in the tree prior." which can be answered using tree model 
>   adequacy (TMA package for BEAST 2). Some context to clarify how this 
>   differs from posterior predictive analysis would be good here.

Thanks for this point! We have added this to the manuscript.

 * [ ] Address this point

> * 2. In general, the difference between the pirouette approach and 
>   TMA/posterior predictive method should be explained more clearly, since 
>   it mostly seems to be the starting tree being from a different source, 
>   and in tree statistics used. The twin phylogeny approach is a nice 
>   addition to posterior predictive analysis.

We agree and we have made this clearer in the ms.

 * [ ] Address this point

> * 3. line 53-62 please break up sentence -- this one is really hard to follow.

We have done so.

 * [ ] Address this point

> * 4. line 82ff: "Also recently, Duchene et al. [Duchene et al. 2018] 
>   released a BEAST2 package to assess how well posterior predictive 
>   simulations recover a given tree when using the standard diversification 
>   models. These studies show how current diversification models compare to 
>   one another, but they do not help to assess the importance of a new tree 
>   prior." This misrepresents the work of Duchene et al, which aims to 
>   demonstrate that a tree prior is *adequate* (the package is called TMA = 
>   tree model adequacy), which is pretty much the aim of this paper.

We agree that our wording was awkward. We have rephrased this.

[RJCB: I guess I wrote that blunder. I must have been confused with the 
Duchene et al., 2014 paper?] [RSE: I don’t think it is a blunder. I think 
Duchene et al are testing for tree model adequacy for standard tree priors. 
Pirouette is testing whether non-standard tree priors should be implemented. 
This seems similar but it is subtly but importantly different.]

 * [ ] Check article again
 * [ ] Rewrite blunder

> * 5. Table 1 why is order of abbreviation in legend different from the order 
>   of rows in the table?

We agree that we should have sorted the same way in both cases. 
We changed this to sorting alphabetically 

 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/83:
   Sort values in Table 1 alphabetically 

> * 6. Figure 1 "The twin alignment has the same number of mutations as the 
>   original alignment." and line 188ff: why keep the number of mutations 
>   constant? With the same root height and same mutation rate, there should 
>   be some natural variation in the number of mutations. Fixing these feels 
>   like this could cause unexpected biases, e.g., reduce the variance in the 
>   error measure for the twin tree analysis.

We agree on the point made by the reviewer. We have simplified the setup
accordingly.

RJCB: I suggest to follow the reviewer's idea and use the simpler version.
I've already added an example, 
https://github.com/richelbilderbeek/pirouette_example_18
that simulates a twin alignment with the same mutation rate
(as requested by the reviewer). It can be contrasted with
the orignal setting that uses a twin alignment with the same number
of mutations (and described in the Appendix),
https://github.com/richelbilderbeek/pirouette_example_3

RJCB: Else, the reply would be 'However, we made this choice to keep
the number of mutations constant in order to ensure that the amount
of genetic information of true and twin tree is identical. We did so
because we want to ensure that the comparison between true and twin
pipeline is as fair as possible.'

 * [ ] Simplify the setup, as the reviewer requested
 * [ ] Describe the consequence of this choice in Appendix, comparing
       pirouette example 3 and 18, section 'The effect of equal or 
       equalized mutation rate in the twin alignment'

> * 7. line 142 "nucleotide substitution model, which we will refer to as site 
>   models".
>
>   * 1. Site models include things like gamma rate heterogeneity and proportion invariable sites, so calling a substitution model a site model does not seem to be appropriate.

We agree on that. We have reworded accordingly.

 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/84:
   Call a site model a site model and  
   a nucleotide substitution model a nucleotide substitution model

>   * 2. Are gamma rate heterogeneity and proportion invariable sites supported?

Yes, they can ideed be specified in the inference model, as part 
of the `create_site_model` function.

> * 8. line 146 where does the set of inference models come from?

Thanks, this set indeed appeared out of the blue! We have introduced
the set of inference models more gently, which are simply all standard 
inference models that are appropriate in their most basic form.

 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/85:
   More gently introduce the set of inference models we use

> * 9. If the inference model used in generating data differs from that 
>      inferring the tree, are you really testing the adequacy of the 
>      original model, or doing integration testing of the whole process? 
>      Using the same site and clock model used to generate the alignment 
>      seems to be the natural thing to do, since you are interested in the 
>      tree model, not the clock or site models.

We completely agree! And this is indeed exactly what we do! We have mentioned this
more explicitly in the text.

 * [ ] Do so

> * 10. How to determine an appropriate length of the sequence? 
>   If the sequence is long enough, the site model model for inference will be 
>   the same as that for generating the alignment. Also, for sufficiently 
>   long sequences, the tree prior won't matter (as mentioned in the paper), 
>   so I suppose the sequences should not be too informative. Some discussion 
>   around these issues would be useful.

We have added this discussion [RSE: In the 
discussion you can also add that long sequences will likely violate the 
assumption of the same substitution rate for all loci. Thus, longer sequences 
do not necessarily imply better inference].
Also, we have added a worked example with different DNA sequence lengths.

Also, we've added a worked example with different DNA sequence lengths.

 * [ ] Discuss DNA sequence length in general
 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/64:
   Discuss DNA sequence length in Appendix, section  'The effect of DNA sequence length'

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

Definitely! We have added this, also as a worked example in the Appendix, 
section 'The effect of mutation rate'

 * [ ] Add, also reference to literature
 * [X] https://github.com/richelbilderbeek/pirouette_article/issues/59: 
   Add worked examples with mutation rates from 
   0.0125, 0.025, 0.05, 0.1, 0.2, 0.4, 0.8,
   at https://github.com/richelbilderbeek/pirouette_example_24
 * [G] https://github.com/richelbilderbeek/pirouette_article/issues/70:
   Describe, section 'The effect of mutation rate'

> * 12. Isn't it more natural to define priors on parameters of the site 
>       model (in the spirit of https://github.com/rbouckaert/DeveloperManual/) 
>       instead of fixing them in the set I_1,...,I_N?
[RSE: I don’t quite understand this point.]

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
between two phylogenies. The nLTT statistic is just one of the many options
and simply happens to be our personal favorite.
The Robinson Foulds distance would be just as fine. 
We mention this now in the ms.

 * [ ] Check metrics in TreeStat2 BEAST2 package
 * [ ] Add to ms

> * 14. Line 176 Instead of describing the mechanism for generating a twin 
>   tree, starting with motivation for why one wants to get involved with a 
>   twin tree would be good. This now only starts at line 186 and further.

We have done so.

 * [ ] Reword as such

> * 15. line 568: capitals are missing from the references "bayesian" 
>   "nltt", etc. You might want to check other references as well.

We have corrected this.

 * [ ] https://github.com/richelbilderbeek/pirouette_article/issues/86: 
   Correct capitalization of references

> Out of curiosity:
>
> * 16. Have you identified tree models that are sufficiently different to be 
>   worth implementing in BEAST?

Yes, we have. The question is not so much whether a new tree model yields a 
difference with a BEAST2
standard tree model, but for which parameter settings this starts to matter.
As an example, we used the protracted birth-death 
process [Etienne et al., ?2012], based on the idea that speciation takes time. 
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
We wanted to sepaerate the re-usable part (`pirouette`) from the specifics.
Because the initial research project was in R, `pirouette` ended up being in R.
[RSE: I think that you should argue a bit more about using R. The whole idea 
behind babette was, among others, that life is so much easier in R for most 
biologists.]

To go back in time a bit more, `pirouette` builds on 
`babette` [Bilderbeek & Etienne, 2018], 
an R package to call BEAST2, which was the first spin-off of that same 
biological research project.

A drawback of `babette`, indeed, is that it cannot provide for all BEAST2 
packages: it does have a BEAST2 package manager (called `mauricer`)
and it does allow using one BEAST2 package (NS, for 'Nested Sampling', a
method to estimate the marginal likelihood of an inference model).
This BEAST2 package is used by `pirouette`, but not described in the article.

All in all, putting `pirouette` into a BEAST package may have been an
equally fine option. It just did not happen that way.

