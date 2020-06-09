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

We are happy to read our previous improvements are appreciated. We thank
the previous round of reviewers for that.

# Reviewer(s)' Comments to Author:

## Reviewer: 3

Comments to the Corresponding Author

> the authors mention in their response to the previous reviewers 
> that this package was created from code used in a different project, 
> and I think adding a citation for this original project would be useful 
> as a rationale and example of actual use.

This work is not yet published, but it can be found in 
(1) (the code) and (2) (the article).

 * (1) https://github.com/richelbilderbeek/razzo
 * (2) https://github.com/richelbilderbeek/razzo_article

> there is no mention of coalescent tree priors anywhere in the manuscript, 
> which is strange considering several are supported by the package 
> according to Table 1. 
> In particular, the introduction makes it sound as if 
> all existing tree priors are birth-death processes.

We agree: we underaddressed the coalescent model and mention these more now
in the Introduction [RJCB: 00002].
`pirouette` allows for any BEAST2 tree model in the regular pipeline.
In the twinning pipeline, where a 'most likely' (see 
equation 1) twin tree is simulated from
a true tree, the coalescent models are not implemented yet.
It can be put in by any user, by setting the 'sim_twin_tree_fun' (part 
of the 'twinning_params') to simulate a twin coalescent tree. Wouls someone
write that code, we would happily accept it in `pirouette`.

> some of the models presented in the introduction are already implemented 
> in BEAST2: for instance time-dependent processes in the BDSky package, 
> and some of the SSE models in the bdmm package. 
> Adding these citations would be useful for the reader 
> to better understand what is currently available in BEAST2 or not.

Agreed! We have done so.

 * [ ] Do so

> sections 8.7 through 8.14 of the Supplementary materials 
> need a description of the results and their interpretation. 
> For instance, my read on section 8.11 is that pirouette cannot 
> distinguish between the Yule process and the BD process on the tested tree, 
> but there is nothing in the text to confirm 
> whether I am reading the figures correctly.

Completely agree. We have added an interpretation to each (set of) figure(s).

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
for extant trees. We have added this to the manuscript.

[RSE: State where you do this.]

For us, creating a sampling-through-time tree is not
straightforward, therefore we decided not to test this, also
because we felt this is beyond describing what pirouette does.


[GL: Actually the figure in the supplementary at 8.11 was actually incorrect.
The correct one still shows similar median values but the shape of distributions
are different] 
[RJCB: What do you mean with 'was actually incorrect'?]
[GL: At some point I mention an incorrect figure (in paragraph 8.11). Simply put: the figure that was in the previous version of the manuscript was not the one coming from the repo of the pirouette example. You can open the folder relative to that pirouette example in overleaf and check yourself the two figures. The old one is still there.]

 * [ ] Do put in text

[RJCB: literature: Stadler, Tanja. "Sampling-through-time in birth–death trees." Journal of theoretical biology 267.3 (2010): 396-404.]

> the use of "generative model" to describe the model used for comparison 
> by pirouette, as opposed to the true generating process, was quite 
> confusing to me. I would switch that to "baseline model" or "comparison 
> model" and clarify in the caption of Fig 3 that this model is an already 
> implemented tree prior.

We think this a great suggestion and we rewrote the article to
use the term 'baseline model' for the 'true' pipeline.
For the 'twin' pipeline, however, the baseline model is the generative
model and we kept using the word 'generative' there.
We hope you agree this is a good idea.
[RSE: I am not onvinced by this change of terminology, but let's see how the ms turns out.]

[RJCB: note that it probably should follow that we adapt the figures' labels.
This would demand quite some calculations]

 * [ ] Modify the text as such

### Minor comments

> Table 1: descriptions are missing for the error_fun section

Well spotted! We added these.

 * [x] Done

> l184: the model p_T is only defined in the caption of figure 1, 
> I think the definition needs to be repeated here

We did so:

```
The default option for the twin diversification model p_T 
is to use the standard BD model.
```

[RSE: Remove. Just say where you added the text]

 * [x] Done, 00003

> section 8.1: "Guidelines for empiricists" is a strange title since this 
> package is aimed at developers of tree priors. Consider replacing with 
> "Guidelines for users".

We used the name 'guidelines for empiricists' from a suggestion by another
reviewer. We have renamed to 'guidelines for users'.

 * [x] Done

> l563: Figure 8.6 does not exist

The figure that appears missing in section '8.6' is the one in the main
text. In a previous version, we put the
figure in the Supplementary Materials
as well, until a reviewer suggested to remove this duplication.

[RSE: Mention the correct figure number.]

> Figure 4: the true tree is top left, not top right

Well spotted! We have reworded accordingly.

 * [x] Done!

> some figures (e.g. fig 3, 8) have the distributions be partially transparent, 
> which makes them easier to read. I think all the figures should be like that.

[RSE: Why is it so difficult to change the figures? It does not require new simulations, does it?]
[RJCB: Actually, it would require new sims]
[
  RJCB: I agree with the reviewer. Why don't we have approx 40 bins
  as in the pretty figures? Well, I see here, which I quote from 'pir_plot.R':

  ```
  ##### More aesthetic settings for the plots #####

  n_errors <- length(unique(df_long$error_index))
  bindwidth <- 0.1 / sqrt(n_errors)
  ```

  I would enjoy `pir_plot` to have more aesthetic settings.

  OTOH, Giovanni should first finish his PhD, and re-running takes time
  that I also need for my current job.
  
  [GL: Completely agree!]

  In the end: I suggest to give a lame excuse.
]

 * [ ] Give lame excuse

## Reviewer: 4

> Comments to the Corresponding Author
> In this article, Bilderbeek and colleagues present a piece of software that can assess the adequacy of a hierarchical model of tree, clock, and molecular substitution. Their effort is worthwhile and the manuscript is largely well-written, and with a few changes it should be a useful tool for power-users in phylogenetics.

> Much of the terminology used is inconsistent with previous literature. 
> This needs rectification or justification. For example, the terms 
> importance and error seem to be used interchangeably, and in ways that are 
> not standard in the field. Adequacy or plausibility are used more widely. 
> Importance is rarely used in mainstream statistics or probability, 
> and the authors unlikely to be referring to the term "importance sampling". 
> Error generally refers to stochastic error (generally from using a finite 
> sample), which is not what the authors are aiming at in this article. 
> These terms must be rectified or very clearly justified in the manuscript.

We agree with the reviewer on the use of the word "importance". We
changed it in "impact", as already present in the literature
(see for example [1]).
We believe, instead, that the word "error" is not inappropriate here.
The "stochastic error" is one of the possible errors, but not the only one.
We clarified this in the description section.
[RSE: You have to clarify it here. You can also copy the section. The point is that editors may just read the response letter and then decide instead of reading the whole ms again.]

 * [x] Done, 00006

> (1) The authors must acknowledge that twinning should be performed at least 
> 100 times, and that the example is not useful for rejecting the BD model. 
> (2) On that note, it would be much preferable if the authors referred to the 
> BD model as a DD model, instead of the other way around (line 103). 
> (3) It is very likely that across several parameter combinations there is no 
> distinction between the proposed and implemented models.

[  
  (1) RJCB: unsure if I agree. 
  No idea where the 100x comes from. 
  We used 20x due to time constraints
]
[RSE: Just reply (and put in the ms) that 20x is not enough, and that users should consider 100x or more.]
[
(1) I also think 100 is arbitrary.
However I think he is right and this
would probably make our supplementary
plots much clearer whereas sometimes
it is hard to provide sound interpretations.
All that said, it required too much time
so I agree with you that this is the
answer we have to give.
]

For (2), we have reworded accordingly.

 * [x] Done

[(3) RJCB: agreed, say a BD model with zero extinction]
[RSE: So what is the reply here?]

> The authors must discuss the drawback of forcing the topology on the twin 
> tree. Topology is known to be highly influenced by the diversification 
> process, primarily in epidemiology. Therefore, forcing the topology is 
> placing a constrain on the implemented model to behave like the proposed 
> model, and this makes for an unfair comparison.

We agree that forcing a topology indeed has an effect. Still, we feel
this to be the lesser evil, as we feel that removing this contraint
makes an unfair comparison.
[RSE: State something like: "The topology may indeed be important. However, in the comparisons we consider, DD vs BD, or BD vs Yule, the topology contains no information to distinguish between the models. We have, however, added a sentence in the discussion [?] that for models that make different predictions on topology, the twinning process should be modified in line with this."]

 * [ ] Reword

> The work by Duchene and colleagues is not mentioned in the introduction 
> as indicated in line 273. Also, the authors must acknowledge that the 
> method simultaneously assesses the tree, rates and substitution 
> models (the hierarchical model), as shown also by Duchene and colleagues 
> in previous work (Duchene et al. 2015, MBE, 32(11), 2986-2995).

Indeed, we ruthlessly moved Duchene's work the the discussion, only to save 
words, which was needed to make it to the deadline. In this rewrite,
we have had more time to properly refer to the literature, so we did
as you suggested.

[GL: In another comment he suggests to add it somewhere in Lines 76-81.
I suggest we see if what was present in the previous version could
fit there][RJCB: Agreed]

 * [ ] Actually do so

> I agree with a previous reviewer that this piece is remarkably similar 
> to the approach explored by Duchene and colleagues (not by those authors 
> but actually pioneered by Drummond and Suchard, 2008, BMC 
> genetics, 9(1), 68.). The difference between pirouette and previous work 
> seems to be the focus testing novel models. This is worthwhile and indeed 
> liberates these methods from the constrain of the model itself. However, 
> it would be appropriate if the authors make due acknowledgement of the 
> original literature of that field. Perhaps citing work in Bayesian 
> statistics by Gelman and in phylogenetics by Nick 
> Goldman (1994, Journal Mol Evol, 36(2)), who are pioneers in 
> assessing model adequacy.

Agreed.

 * [ ] Read those papers
 * [ ] Acknowledge these

[RJCB: reference to literature: Drummond, Alexei J., and Marc A. Suchard. "Fully Bayesian tests of neutrality using genealogical summary statistics." BMC genetics 9.1 (2008): 68.]

> Interestingly, the type of assessment proposed by the authors is a form of 
> approximate model comparison, which they could consider mentioning 
> explicitly. Critically, it looks like the test statistics proposed are 
> not appropriate in light of recent research (Louca and 
> Pennel, 2020, Nature), so the authors should mention the addition of test 
> statistics that can more reliably discriminate among models.

 * [ ] Read Louca and Pennel [RSE: Louca & Pennell only argue that the LTT cannot distinguish between the constant-rate model and a family of time-dependent model. It can still discriminate between various BD models and between DD and BD.]
 * [ ] Answer

### Minor comments

> Abstract. Point 3 is not actually explicitly explained in the manuscript 
> and the question does not seem biological. Instead, the abstract can
> indicate that the pirouette interrogates a model for its power to describe another.

[RJCB: the line he/she refers to: 'We describe pirouette’s usage and 
the biological scientific question it can answer, including full examples']
[RJCB: I feel his/her suggestion is really a nice way to describe pirouette!]
[GL: Agree]
[RSE:So what is the response?]

 * [ ] Done

> Line 23. There is no real difference between free and libre, 
> and in fact the latter does not appear in english dictionaries.

'Libre' came form the abbreviation 'FLOSS' ('Free, Libre and Open Source 
Software'), as coined by Richard Stallman, where the 'L' helps
stress that the 'Free' is 'free as in speech', which can be translated
to 'Libre' (unlike 'free as in beer', which would be translated to 'Gratis').
But indeed, not everyone may value the addition of the 'L', so we removed it.

> Line 40. Time-stamped data where samples come from various time points 
> are very widely used in phylogenetics too.

We have added this at ...

 * [x] Added this, 00004

> Line 46. I would argue that coalescent models are used as often 
> as birth-death models, so this statement is probably inaccurate.

We reworded accordingly

 * [x] Done so, 00002

> Line 49. BEAST 2 is not the successor of BEAST 1. The latter is still being 
> actively developed and has features that are not available in BEAST 2.

Agreed. We've reworded accordingly.

 * [x] Did so at '00001'

> Line 62. A great range of models are implemented in BEAST 2 (and 1), 
> including many coalescent models, multispecies coalescent, BD skyline, etc.

We have added these.

 * [ ] Add these at 00005

> Line 73. This might also occur if the prior is truly 
> uninformative (e.g., a reference prior).

 * [x] We mentioned it in the manuscript.

> Lines 76-81. This paragraph should cite other explorations of tree priors 
> that show that the tree prior can have a great influence (e.g., Ritchie 
> et al. 2017, Syst Biol 66(3)). This is also a good stage to introduce the 
> concept of assessing model adequacy.

 * [ ] Do so

> Table 2. Models of rates across sites are not included in the substitution 
> models. It is quite important to include this form of heterogeneity 
> since it is common in empirical data and fundamental for 
> phylogenetic informativeness.

Well spotted! Because we use the same defaults as BEAUti does (which does not
assume a rate heterogeneity), we overlooked this. We mention this is the 
table now. 
 
 * [ ] Do so

> Line 139. Describe the term "mononucleotide blocks".

Sorry that this term has caused confusion. We have done so:

```
text here
```

 * [ ] Do so

> Line 187. There is no mention of how missing data (sampling fraction) 
> are handled during simulation. This might have an important influence on 
> model performance.

Indeed, in all cases we assumed a sampling fraction of 100 percent.
We mention that this may have an effect.

 * [ ] Do so

> Line 193. These models are not quite mutations models, but rather 
> substitutions models.

We have never used the expression 'mutation model'. We assume that
the reviewer refers to the use of the word 'mutation', used to
refer to the change of one nucleotide into
a different one. In such cases we replaced them with
the word 'substitution'.

 * [x] Done

> Figure 1. The alignments shown are not aligned! 
> No serious phylogenetics study would believe those have homology.

We agree that this alignment looks different from what one normally finds
in the field. In this case, we simulated the alignments with the maximum
amount of information present. It can be viewed as only taking the SNPs
from an alignment.

 * [ ] Explain in text

> Figure 3. Remove the title because it is superfluous.

 * [x] Done

[1] Sarver, B.A., Pennell, M.W., Brown, J.W., Keeble, S., Hardwick, K.M., Sullivan, J. & Harmon, L.J. (2019) The choice of tree prior and molecular clock does not substantially affect phylogenetic inferences of diversification rates. PeerJ, 7, e6334

