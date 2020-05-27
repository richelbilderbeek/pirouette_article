---------- Forwarded message ---------
Da: Methods in Ecology and Evolution [...]
Date: lun 18 mag 2020 alle ore 16:11
Subject: Methods in Ecology and Evolution - Decision on Manuscript ID MEE-20-03-251
To: [...]


18-May-2020

MEE-20-03-251 Quantifying the importance of an inference model in Bayesian phylogenetics

MEE-20-03-251 Quantifying the importance of an inference model in Bayesian phylogenetics

Dear Mr Giovanni Laudanno,

Thank you for submitting your manuscript to Methods in Ecology and Evolution. I have now received the reviewers' reports and a recommendation from the Associate Editor who handled the review process of your resubmission. Copies of their reports are included below. This manuscript has the potential to make a valuable contribution to the area, but there are still a number of significant concerns that need to be addressed. I have considered your paper in light of the comments received and I would like to invite you to prepare a revision.

In your revision, please make sure that you take full account of the comments  made in the reports below. Please note that Methods in Ecology and Evolution does not automatically accept papers after revision, and an invitation to revise a manuscript does not represent commitment to eventual publication on our part. We will reject revised manuscripts if they are returned without satisfactory responses to the reviewers' comments. When returning the revised paper, please show point-by-point how you have dealt with the various comments in the appropriate section of the submission form.

Please return your revision by 29-Jun-2020. If you need longer, please let us know so we can update our system accordingly.  Please read the resubmission instructions at the end of this email before submitting your updated manuscript.


We look forward to hearing from you in due course.

Sincerely,

Dr Lee Hsiang Liow
Senior Editor, Methods in Ecology and Evolution

Reply to:
Ms India Stephenson
Methods in Ecology and Evolution Editorial Office
[...]


Associate Editor Comments to Author:
Associate Editor
Comments to the Author:
This is a much-improved version of the manuscript. It will be a nice contribution, but as pointed out by both reviewers there are still a few issues that need to be better explained for the paper to be ready for publication. The following points raised by the reviewers were of particular interest: 1- better refer to previous work, making it explicitly clear what are novel aspects of pirouette; 2- re-work some of the terminology, including making it  more congruent with previous usage (or alternatively justify the use of some terms); better describe some of the results and interpretations of some of the supplemental sections (in particular sections 8.7 through 8.14).


Reviewer(s)' Comments to Author:
Reviewer: 3

Comments to the Corresponding Author
This manuscript by Bilderbeek et al. presents an R package whose purpose is to evaluate the value of new tree priors, by calculating the error introduced by using a different tree prior than the one which generated the tree.
Overall, I think this package and its goal are interesting and worth publishing, but the presentation could be improved on several points.

Detailed comments
- the authors mention in their response to the previous reviewers that this package was created from code used in a different project, and I think adding a citation for this original project would be useful as a rationale and example of actual use.
- there is no mention of coalescent tree priors anywhere in the manuscript, which is strange considering several are supported by the package according to Table 1. In particular, the introduction makes it sound as if all existing tree priors are birth-death processes.
- some of the models presented in the introduction are already implemented in BEAST2: for instance time-dependent processes in the BDSky package, and some of the SSE models in the bdmm package. Adding these citations would be useful for the reader to better understand what is currently available in BEAST2 or not.
- sections 8.7 through 8.14 of the Supplementary materials need a description of the results and their interpretation. For instance, my read on section 8.11 is that pirouette cannot distinguish between the Yule process and the BD process on the tested tree, but there is nothing in the text to confirm whether I am reading the figures correctly.
- the twinning procedure is interesting but I am not confident that it produces trees matching the chosen generating process. As far as I understand all the twin trees in the manuscript were produced using the BD process, however the best candidate model on the twin trees is frequently the Yule model. This and the supplementary seem to confirm that the proposed method cannot distinguish between Yule and BD. If true, this is an important caveat, as the purpose of the package is to evaluate the differences between tree priors. One possible explanation is that the tested trees were purely extant, which is known to affect extinction estimates ; it should be straightforward to confirm or infirm this hypothesis using a sampling-through-time tree.
- the use of "generative model" to describe the model used for comparison by pirouette, as opposed to the true generating process, was quite confusing to me. I would switch that to "baseline model" or "comparison model" and clarify in the caption of Fig 3 that this model is an already implemented tree prior.

Minor comments
- Table 1: descriptions are missing for the error_fun section
- l184: the model p_T is only defined in the caption of figure 1, I think the definition needs to be repeated here
- section 8.1: "Guidelines for empiricists" is a strange title since this package is aimed at developers of tree priors. Consider replacing with "Guidelines for users".
- l563: Figure 8.6 does not exist
- Figure 4: the true tree is top left, not top right
- some figures (e.g. fig 3, 8) have the distributions be partially transparent, which makes them easier to read. I think all the figures should be like that.

Reviewer: 4

Comments to the Corresponding Author
In this article, Bilderbeek and colleagues present a piece of software that can assess the adequacy of a hierarchical model of tree, clock, and molecular substitution. Their effort is worthwhile and the manuscript is largely well-written, and with a few changes it should be a useful tool for power-users in phylogenetics.

Much of the terminology used is inconsistent with previous literature. This needs rectification or justification. For example, the terms importance and error seem to be used interchangeably, and in ways that are not standard in the field. Adequacy or plausibility are used more widely. Importance is rarely used in mainstream statistics or probability, and the authors unlikely to be referring to the term "importance sampling". Error generally refers to stochastic error (generally from using a finite sample), which is not what the authors are aiming at in this article. These terms must be rectified or very clearly justified in the manuscript.

The authors must acknowledge that twinning should be performed at least 100 times, and that the example is not useful for rejecting the BD model. On that note, it would be much preferable if the authors referred to the BD model as a DD model, instead of the other way around (line 103). It is very likely that across several parameter combinations there is no distinction between the proposed and implemented models.

The authors must discuss the drawback of forcing the topology on the twin tree. Topology is known to be highly influenced by the diversification process, primarily in epidemiology. Therefore, forcing the topology is placing a constrain on the implemented model to behave like the proposed model, and this makes for an unfair comparison.

The work by Duchene and colleagues is not mentioned in the introduction as indicated in line 273. Also, the authors must acknowledge that the method simultaneously assesses the tree, rates and substitution models (the hierarchical model), as shown also by Duchene and colleagues in previous work (Duchene et al. 2015, MBE, 32(11), 2986-2995).

I agree with a previous reviewer that this piece is remarkably similar to the approach explored by Duchene and colleagues (not by those authors but actually pioneered by Drummond and Suchard, 2008, BMC genetics, 9(1), 68.). The difference between pirouette and previous work seems to be the focus testing novel models. This is worthwhile and indeed liberates these methods from the constrain of the model itself. However, it would be appropriate if the authors make due acknowledgement of the original literature of that field. Perhaps citing work in Bayesian statistics by Gelman and in phylogenetics by Nick Goldman (1994, Journal Mol Evol, 36(2)), who are pioneers in assessing model adequacy.

Interestingly, the type of assessment proposed by the authors is a form of approximate model comparison, which they could consider mentioning explicitly. Critically, it looks like the test statistics proposed are not appropriate in light of recent research (Louca and Pennel, 2020, Nature), so the authors should mention the addition of test statistics that can more reliably discriminate among models.

Minor comments:
Abstract. Point 3 is not actually explicitly explained in the manuscript and the question does not seem biological. Instead, the abstract can indicate that the pirouette interrogates a model for its power to describe another.
Line 23. There is no real difference between free and libre, and in fact the latter does not appear in english dictionaries.
Line 40. Time-stamped data where samples come from various time points are very widely used in phylogenetics too.
Line 46. I would argue that coalescent models are used as often as birth-death models, so this statement is probably inaccurate.
Line 49. BEAST 2 is not the successor of BEAST 1. The latter is still being actively developed and has features that are not available in BEAST 2.
Line 62. A great range of models are implemented in BEAST 2 (and 1), including many coalescent models, multispecies coalescent, BD skyline, etc.
Line 73. This might also occur if the prior is truly uninformative (e.g., a reference prior).
Lines 76-81. This paragraph should cite other explorations of tree priors that show that the tree prior can have a great influence (e.g., Ritchie et al. 2017, Syst Biol 66(3)). This is also a good stage to introduce the concept of assessing model adequacy.
Table 2. Models of rates across sites are not included in the substitution models. It is quite important to include this form of heterogeneity since it is common in empirical data and fundamental for phylogenetic informativeness.
Line 139. Describe the term "mononucleotide blocks".
Line 187. There is no mention of how missing data (sampling fraction) are handled during simulation. This might have an important influence on model performance.
Line 193. These models are not quite mutations models, but rather substitutions models.
Figure 1. The alignments shown are not aligned! No serious phylogenetics study would believe those have homology.
Figure 3. Remove the title because it is superfluous.

+++++
RESUBMISSION INSTRUCTIONS
Please note that resubmitting your manuscript does not guarantee eventual acceptance, and that your resubmission may be subject to re-review before a decision is rendered. Please also ensure that your altered manuscript still conforms to our word limit of 6000-7000 for research articles, or 3000 for applications.

Once you have made the suggested changes, go to https://mc.manuscriptcentral.com/mee-besjournals and login to your Author Centre. Click on "Manuscripts with Decisions," and then click on "Create a Resubmission" located next to the manuscript number. Then, follow the steps for resubmitting your manuscript. Your original files are available to you when you upload your revised manuscript.  Please delete any redundant files before completing the submission

When submitting your revised manuscript, you will be able to respond to the comments made by the reviewer(s) in the space provided.  You can use this space to document any changes you make to the original manuscript.  In order to expedite the processing of the revised manuscript, please be as specific as possible in your response to the reviewer(s).

Because we are trying to facilitate timely publication of manuscripts submitted to Methods in Ecology and Evolution, your new manuscript should be uploaded by 29-Jun-2020. If it is not possible for you to submit your manuscript by that date, please get in touch with the editorial office, otherwise we will consider your paper as a completely new submission.

