Associate Editor Comments to Author:
Associate Editor
Comments to the Author:

> This is a much-improved version of the manuscript. It will be a nice 
> contribution, but as pointed out by both reviewers there are still a 
> few issues that need to be better explained 
> for the paper to be ready for publication. 
> The following points raised by the reviewers were of particular interest: 
> 1- better refer to previous work, making it explicitly clear what are 
> novel aspects of pirouette; 2- re-work some of the terminology, 
> including making it  more congruent with previous usage (or alternatively 
> justify the use of some terms); better describe some of the results 
> and interpretations of some of the supplemental sections (in particular 
> sections 8.7 through 8.14).

We are glad that our revisions went in the right direction. We thank 
you and the reviewers for your help. We address the points you mentioned
above (along with the others) in the point by point response below.

# Reviewer(s)' Comments to Author:

## Reviewer: 3

## Comments to the Corresponding Author

> the authors mention in their response to the previous reviewers 
> that this package was created from code used in a different project, 
> and I think adding a citation for this original project would be useful 
> as a rationale and example of actual use.

This work is not yet published, therefore we chose not to mention it.
Currently, the project can be found at
(1) (the code) and (2) (the article).

 * (1) https://github.com/richelbilderbeek/razzo
 * (2) https://github.com/richelbilderbeek/razzo_article

> there is no mention of coalescent tree priors anywhere in the manuscript, 
> which is strange considering several are supported by the package 
> according to Table 1. 
> In particular, the introduction makes it sound as if 
> all existing tree priors are birth-death processes.

We agree: we under-addressed the coalescent models and now refer
to coalescent models in the Introduction:

"BEAST has built-in priors such as the Yule [Yule 1925] and 
(constant-rate) birth-death [Nee et al. 1994] models
as well as coalescent priors."

Regarding the range of options available within pirouette,
indeed, the implemented tree priors for the twinning process are Yule
and BD.
However, a user can also specify any other way to simulate a twin tree,
such as, for example, one that uses a coalescent model. We mention this
explicitly in the 'Twinning' subsection:

"pirouette has a built-in function to use a Yule model as well.
Additionally, a user can specify a function to generate a twin tree
from any speciation model, such as, for example, a coalescent model."

> some of the models presented in the introduction are already implemented 
> in BEAST2: for instance time-dependent processes in the BDSky package, 
> and some of the SSE models in the bdmm package. 
> Adding these citations would be useful for the reader 
> to better understand what is currently available in BEAST2 or not.

Agreed! We have done so in the Introduction. Because there are so
many, we chose to limit ourselves to all BD tree priors listed
at [http://www.beast2.org/beast-features/index.html](http://www.beast2.org/beast-features/index.html). 
This resulted in:

"Plugins have been provided, for instance, the calibrated Yule model (Heled et al., 2015),
BD with incomplete sampling (Stadler et al., 2009),
BD serial sampling (Stadler et al., 2012),
BD serial skyline (Stadler et al., 2013)
Fossilized BD process (Gavryushkina et al., 2014), and
BD SIR (Kuhnert et al., 2014)."

> sections 8.7 through 8.14 of the Supplementary materials 
> need a description of the results and their interpretation. 
> For instance, my read on section 8.11 is that pirouette cannot 
> distinguish between the Yule process and the BD process on the tested tree, 
> but there is nothing in the text to confirm 
> whether I am reading the figures correctly.

Completely agree. We have added an interpretation to each (set of) figure(s).

### Comment

> the twinning procedure is interesting but I am not confident that 
> it produces trees matching the chosen generating process. As far as I 
> understand all the twin trees in the manuscript were produced using 
> the BD process, however the best candidate model on the twin trees is 
> frequently the Yule model. This and the supplementary seem to confirm that 
> the proposed method cannot distinguish between Yule and BD. If true, this 
> is an important caveat, as the purpose of the package is to evaluate the 
> differences between tree priors. One possible explanation is that the 
> tested trees were purely extant, which is known to affect extinction 
> estimates ; it should be straightforward to confirm or infirm this 
> hypothesis using a sampling-through-time tree.

In 7 out of 19 cases, indeed, the best candidate model is the Yule
model. And we think that is an interesting point you bring up: 
that the method may be unable to distinguish between Yule and BD
for extant trees. We have added this to the manuscript
at the subsection 'The effect of assuming a Yule tree prior on a BD tree'

We believe that further testing with a sampling-through-time tree is beyond 
describing what pirouette does, which is the purpose of this manuscript.

> the use of "generative model" to describe the model used for comparison 
> by pirouette, as opposed to the true generating process, was quite 
> confusing to me. I would switch that to "baseline model" or "comparison 
> model" and clarify in the caption of Fig 3 that this model is an already 
> implemented tree prior.

Thanks for pointing out this point of confusion!
We hope to have resolved this, in the Introduction
using your (well-chosen!) synonyms:

"A 'generative tree model', in this paper, is always a standard tree model.
If the actual model that generated the tree is non-standard, 
the 'generative tree model' is the (standard) tree model that is (assumed
to be) closest to the actual (non-standard) model. In that case, the
'generative tree model' can also be called 'baseline model' 
or 'comparison model'."

[RSE: I find this still confusing. I would then use baseline model all the time.]

### Minor comments

> Table 1: descriptions are missing for the error_fun section

Well spotted! We added these, at the error_fun section.

"nLTT = normalized lineages-through-time (Janzen et al., 2015),
|gamma| = absolute value of the gamma statistic (Pybus, 2000)."

> l184: the model p_T is only defined in the caption of figure 1, 
> I think the definition needs to be repeated here

Thanks! We now repeat it in the 'twinning' section:

"The default option for the twin diversification model $p_T$ 
is the standard BD model."

> section 8.1: "Guidelines for empiricists" is a strange title since this 
> package is aimed at developers of tree priors. Consider replacing with 
> "Guidelines for users".

We used the name 'guidelines for empiricists' from a suggestion by another
reviewer. We have renamed to 'guidelines for users'.

> l563: Figure 8.6 does not exist

We mistakenly referred to the section instead of the figure. We corrected
this. Now we refer to the right figure: Figure 4.

> Figure 4: the true tree is top left, not top right

We have reworded the figure accordingly.

> some figures (e.g. fig 3, 8) have the distributions be partially transparent, 
> which makes them easier to read. I think all the figures should be like that.

```
********************************************************************************
* TODO 1: Richel does so                                                       *
********************************************************************************
```

## Reviewer: 4

> Comments to the Corresponding Author
> In this article, Bilderbeek and colleagues present a piece of software 
> that can assess the adequacy of a hierarchical model of tree, 
> clock, and molecular substitution. Their effort is worthwhile and the 
> manuscript is largely well-written, and with a few changes it should 
> be a useful tool for power-users in phylogenetics.

> Much of the terminology used is inconsistent with previous literature. 
> This needs rectification or justification. For example, the terms 
> importance and error seem to be used interchangeably, and in ways that are 
> not standard in the field. Adequacy or plausibility are used more widely. 
> Importance is rarely used in mainstream statistics or probability, 
> and the authors unlikely to be referring to the term "importance sampling". 
> Error generally refers to stochastic error (generally from using a finite 
> sample), which is not what the authors are aiming at in this article. 
> These terms must be rectified or very clearly justified in the manuscript.

Thanks for helping us improve upon our choice of words!
We agree with the reviewer on the use of the word "importance". We
changed it to "impact", as already present in the literature
(see for example [1]).
We believe, instead, that the word "error" is not inappropriate here.
The "stochastic error" is one of the possible errors, but not the only one.
We clarified this in the description section adding the following
lines: "The error we aim to quantify is not of stochastic nature.
Stochastic errors are usually non-directional.
We, instead, aim to expose the bias due to the mismatch
between generative and inference models."

> (1) The authors must acknowledge that twinning should be performed at least 
> 100 times, and that the example is not useful for rejecting the BD model. 

We agree with the reviewer. Our aim in the main text is just to present
how the algorithm works with a minimal example.

We clarified adding that the analysis should be performed on "at least 100 independent true and twin trees" in the section "Stochasticity caused by simulating phylogenies"

> (2) On that note, it would be much preferable if the authors referred to the 
> BD model as a DD model, instead of the other way around (line 103). 

We have rephrased the sentence. Now it states that:
"The BD model can be seen as a special case of the DD model".

> (3) It is very likely that across several parameter combinations there is no 
> distinction between the proposed and implemented models.

It is indeed true that the inference error will depend on the
parameters used to simulate input phylogenies.
For example for very large carrying capacities we expect
the DD process to be indistinguishable from a BD process.
Pirouette can be used to assess how the error vary
for different generative parameter combinations.
However, presenting a full study goes beyond the scope
of this manuscript.

> The authors must discuss the drawback of forcing the topology on the twin 
> tree. Topology is known to be highly influenced by the diversification 
> process, primarily in epidemiology. Therefore, forcing the topology is 
> placing a constrain on the implemented model to behave like the proposed 
> model, and this makes for an unfair comparison.

We agree that forcing a topology can indeed have an effect. 
However, for the DD model in our example and many other new diversification 
models, all topologies are equally likely.

Nevertheless, to stress the importance that topology might have in other cases, 
we mentioned the issue both in the twinning section and in the discussion:

"We choose to preserve the original topology to 
increase the similarity between the twin to the original tree. 
This works well in the cases of birth-death or diversity-dependent models 
we consider in our example, because all these models make the same
assumption about the topology (all topologies are equally likely).
However, this might not be suited for new models that assign different probabilities
to trees with the same branching times but different topologies.""

"For models that make different 
predictions on topology, the twinning process should be modified accordingly."

> The work by Duchene and colleagues is not mentioned in the introduction 
> as indicated in line 273. Also, the authors must acknowledge that the 
> method simultaneously assesses the tree, rates and substitution 
> models (the hierarchical model), as shown also by Duchene and colleagues 
> in previous work (Duchene et al. 2015, MBE, 32(11), 2986-2995).

Indeed, we moved Duchene's work the the discussion, only to save 
words, which was needed to make it to the deadline. For this revision,
we had more time to properly refer to the literature.

We now devote a whole paragraph to Duchene's 2018 work:

"As noted in the introduction, Duchene and 
colleagues [Duchene et al., 2018],
also developed a method to assess the adequacy of a tree model
on empirical trees. They simulate trees from the posterior distribution of 
the parameters and then compare this to the originally inferred tree using 
tree statistics, to determine whether the assumed tree model in inference 
indeed generates the tree as inferred. This is useful if these trees match, 
but when they do not, this does not mean that the inferred tree is incorrect; 
if sufficient data is available the species tree prior may not be important, 
and hence the inference may be adequate 
even though the assumed species tree prior is not. 
In short, the approach is applied to empirical trees and 
compares the posterior and prior distribution of trees (with the latter 
generated with the posterior parameters!).
pirouette aims to identify when assuming standard priors for the 
species tree leads to incorrect inference if one believes more complex 
diversification models are operating than can be currently accommodated in 
inference. In short, our approach applies to simulated trees and compares 
the posterior distributions of trees generated with 
a standard and non-standard model, but inferred with a standard one. 
The two methods therefore complement one another."

We added refer to Duchene's 2015 work and one of its findings:

"This new method simultaneously assesses the substitution, clock and tree
models and thus is a hierarchical model.
We learn from (Duchene et al., 2015) that 
such a method may be sensitive to other aspects of the hierarchical model."

[RSE: I find the use of hierarchical odd]

> I agree with a previous reviewer that this piece is remarkably similar 
> to the approach explored by Duchene and colleagues (not by those authors 
> but actually pioneered by Drummond and Suchard, 2008, BMC 
> genetics, 9(1), 68.). The difference between pirouette and previous work 
> seems to be the focus testing novel models. This is worthwhile and indeed 
> liberates these methods from the constrain of the model itself. However, 
> it would be appropriate if the authors make due acknowledgment of the 
> original literature of that field. Perhaps citing work in Bayesian 
> statistics by Gelman and in phylogenetics by Nick 
> Goldman (1994, Journal Mol Evol, 36(2)), who are pioneers in 
> assessing model adequacy.

Indeed, the difference between pirouette and previous work 
is the focus on testing novel models. We have taken some care (also due
to other reviewers' comments) to make this more clear.

We have added this in the Introduction:

"Another way to benchmark a diversification model, is by doing
a model comparison, in which the best model is determined
from a set of models. A good early example is Goldman, 1993 
in which Goldman compared DNA substitution models.
A recent approach to test the impact of tree prior choice, is developed
by Duchene, 2018, which allows to measure
a model's adequacy for phylodynamic models that are
mathematically described (i.e. have a known likelihood equation)."

> Interestingly, the type of assessment proposed by the authors is a form of 
> approximate model comparison, which they could consider mentioning 
> explicitly. Critically, it looks like the test statistics proposed are 
> not appropriate in light of recent research (Louca and 
> Pennell, 2020, Nature), so the authors should mention the addition of test 
> statistics that can more reliably discriminate among models.

Indeed, Louca and Pennell argue that the LTT cannot distinguish between the 
constant-rate model and a family of time-dependent model.
However (and lucky for us!), the nLTT statistic can still discriminate between 
various BD models and between DD and BD.
We added your suggestion to where we mention the nLTT statistic:

"The nLTT statistic is unsuitable, however, to distinguish
between a constant-rate BD model and a family of time-dependent 
models [Louca and Pennell, 2020]".
 
### Minor comments

> Abstract. Point 3 is not actually explicitly explained in the manuscript 
> and the question does not seem biological. Instead, the abstract can
> indicate that the pirouette interrogates a model for its power to describe another.

We rephrased point 3 in the abstract as following:
"We describe pirouette's usage providing full examples in which
we interrogate a model for its power to describe another."

> Line 23. There is no real difference between free and libre, 
> and in fact the latter does not appear in English dictionaries.

'Libre' came form the abbreviation 'FLOSS' ('Free, Libre and Open Source 
Software'), as coined by Richard Stallman, where the 'L' helps
stress that the 'Free' is 'free as in speech', which can be translated
to 'Libre' (unlike 'free as in beer', which would be translated to 'Gratis').
But indeed, not everyone may value the addition of the 'L', so we removed it.

> Line 40. Time-stamped data where samples come from various time points 
> are very widely used in phylogenetics too.

Indeed. We have added this to the Introduction:

> "The development of new powerful Bayesian phylogenetic inference tools, 
> such as [...]
> has been a major advance in constructing phylogenetic trees 
> from character data [...] extracted from organisms
> (usually extant, but extinction events
> and/or time-stamped data can be added), 
> and hence in our understanding of the main drivers 
> and modes of diversification."

> Line 46. I would argue that coalescent models are used as often 
> as birth-death models, so this statement is probably inaccurate.

We rephrased the sentence as: "These simple tree priors
are among the most commonly used." and "In this paper, we focus on BD models, 
instead of coalescent models, although these are just as important."

> Line 49. BEAST 2 is not the successor of BEAST 1. The latter is still being 
> actively developed and has features that are not available in BEAST 2.

We rephrased the sentence as: "To allow users to extend the
functionalities of BEAST by using plug-ins, BEAST2 was written
and both tools are still developed independently."

> Line 62. A great range of models are implemented in BEAST 2 (and 1), 
> including many coalescent models, multi-species coalescent, BD skyline, etc.

We have added these in the Introduction:

> "Despite the fact that some models are already included as tree priors 
> in BEAST2 (e.g. birth-death models, coalescent models, coalescent skyline, etc.) 
> many others for which a likelihood formula is already available 
> in literature, are not implemented yet."


> Line 73. This might also occur if the prior is truly 
> uninformative (e.g., a reference prior).

Indeed! We mention this now in the Introduction:

> "This is not necessarily problematic, when the data are very informative 
> or when the prior is truly uninformative, as this will reduce the influence 
> of the tree prior."


> Lines 76-81. This paragraph should cite other explorations of tree priors 
> that show that the tree prior can have a great influence (e.g., Ritchie 
> et al. 2017, Syst Biol 66(3)). This is also a good stage to introduce the 
> concept of assessing model adequacy.

```
********************************************************************************
* TODO 2: Need Rampal for this                                                 *
********************************************************************************
```

 * [ ] Do so

> Table 2. Models of rates across sites are not included in the substitution 
> models. It is quite important to include this form of heterogeneity 
> since it is common in empirical data and fundamental for 
> phylogenetic informativeness.

Agreed! The rate variation accross sites is part of the site model,
which (the site model) includes the substitution model.

We added this to the Table with definitions:
"Site model [equals] Both the substitution model and rate variation 
across sites."

> Line 139. Describe the term "mono-nucleotide blocks".

We added the following line to explain what we mean with "mono-nucleotide block":
"A block of length n is a sequence in which the same character is repeated n times".

> Line 187. There is no mention of how missing data (sampling fraction) 
> are handled during simulation. This might have an important influence on 
> model performance.

Indeed, in all cases we assumed a sampling fraction of 100 percent.
We now added the following line to clarify this:
"For simplicity, when simulating phylogenies we assumed a sampling fraction of 100%.
A different choice might have an effect on model performance."

> Line 193. These models are not quite mutations models, but rather 
> substitutions models.

We have never used the expression 'mutation model'. We assume that
the reviewer refers to the use of the word 'mutation', used to
refer to the change of one nucleotide into
a different one. In such cases we replaced them with
the word 'substitution'.

> Figure 1. The alignments shown are not aligned! 
> No serious phylogenetics study would believe those have homology.

We agree that this alignment looks different from what one normally finds
in the field. In this case, we simulated the alignments with the maximum
amount of information present.

> Figure 3. Remove the title because it is superfluous.

Done.

## References

 * [1] Sarver, B.A., Pennell, M.W., Brown, J.W., Keeble, S., Hardwick, K.M., Sullivan, J. & Harmon, L.J. (2019) The choice of tree prior and molecular clock does not substantially affect phylogenetic inferences of diversification rates. PeerJ, 7, e6334

