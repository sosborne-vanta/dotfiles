# Scott's writing samples

Verbatim excerpts, grouped by where they were written. Spacing and punctuation are his. Use these to calibrate `voice.md`; don't quote them.

## PR review comments (inline)

> I think I have this same change in my pr [here](...)
>
> It was just enqueued to merge, so you'll need to resolve

> I think this may have already been added to the TrustReport GQL object directly??
>
> Actually, looks like that's also in my PR that is in the merge queue [here](...)

> This already exists somewhere else, reuse it

> I think @donton wanted a limit on this, like up to 3 tab names, but over that, it says something like "Pricing, Docs, and 2 more tabs")
>
> Could be a design follow-up

> OK, go ahead with this one.  I thought there was already a hook in the front-end somewhere for this... but I also can't find it.  Ideally, it would just be defined in a shared helper.
>
> I was thinking of this one on the 'web' side: https://github.com/VantaInc/obsidian/blob/main/packages/web-customer-trust-management/src/trust-center/graphql/resolvers/queries/TrustReport.ts#L317

> Hmm... the registry entry defines the auth method... but it still feels like there's something missing here.
>
> The auth is still check for the provided resources in this method.  Maybe that check should be described here.

> This is probably a fine default for now.  If you look down below, this endpoint is actually doing an auth assert on `canViewActors` and `canViewOwnedObjects`
>
> It's not set up very well for authorization right now.

## PR review summaries

> lgtm

> trust center approve

> re-approve

> thanks for the video.  approach looks good

> Let's rebase this after mine merges and see how much is still needed

> wow, i'm not sure when this would happen, but seems fine to me

> OOF, big prompt change, thanks for doing lots of testing

> I think this is good to go, but I would do one last check on the styling, the screenshot looks like the spacing is too wide between the title and subtitle, here's the protokit

> Walked through testing with Taoran.  Ready to approve

> Thanks for the preview.  looks like a workable solution!

> The lift looks fine.
>
> I'm not totally understanding why we're building separate front-door files for all the REST operations. Why aren't these just normal front-door operations?

> Tested with and without flag and seems ok, didn't notice any errors.

> Great approach!  I have the PR for the mutations here, should be ready for review tomorrow https://github.com/VantaInc/obsidian/pull/202499

> Approach is clean and  looks good, here are some suggestions from Claude on what to watch out for in the next step:
>
> Things to watch when it is wired to the tab page (CTAUTO-2407's second half)
>
> - The `OverviewColumnProvider` gap above is the one that will bite first. The tab page uses the same two-column layout as Home but never mounts the provider.

## PR descriptions (hand-written)

> ## Changes
>
> Interpret quick view filters correctly for the NEEDS_MY_APPROVAL option and pass correct options down to pagination service
>
> ## Motivation
>
> [Bug bash](...) identified that the filter wasn't working correctly for assigned approvers.
>
> ## Testing
>
> https://www.loom.com/share/...
>
> ## Deployment
> no flag needed, forward fix, revertible

> This second PR is part of the strangler fig pattern. The first PR replaced the inner logic of the existing methods with calls to the new service.  This PR replaces the actual usages of the deprecated methods with direct calls to the service. Then deletes those unused methods.

> Most file changes are mechanical import swaps. Focus review on:
> - `questionnaireDataLoaders.ts` (the removals)
> - `questionnairesService.ts` and the two registry files where `findByIds` now uses the `Map` return type directly with `assertMongoObjectId`

## Eng spec prose

> We're having trouble with various background jobs not fitting neatly into the core-platform SLO expectations.  Many of our background jobs incorporate AI calls or 3rd party service calls that utilize AI.  And these processes can be variable depending on the query and size of the data.

> We can just utilize the jobArgs to pass additional retry details and manage the retry attempts internally.  Job args might look something like this:

> And then internally, if the Reducto requested job is not finished, we could manually enqueue a follow up job and exit normally (success):

> Basically the same workflow as above, but with a button for 'Approve' instead of 'Answer' and corresponding event listeners to perform the 'approve' action and update the original message.

> Only for single question notifications?  Maybe we trigger it all the time since we won't necessarily know without looking it up

> We could save the slack message data directly on the QuestionnaireResponse object.  It would be easy to find and is a good lightweight solution until we have more usage patterns from other types of notifications and interactions.

> The access request team created their own collection to store slack message data with the context they care about.  It is pretty close to being generic, but has an accessRequestId specific to their entity. We could create our own collection similar to this and potentially merge them into a more generic version in the future.

> Take the idea from Option 2 and actually create a generic repository for slack message info.
> - Would have to handle generic type of entity link.
> - What about batched notifications, one document per entity in batch
> - This is only the second use case for slack message storage, maybe we need to wait until we have a few more use cases.

> Not sure how often you need to do this, but re-auth if you see "stack: Error: An API error occurred: token_expired"

## North Star doc prose

> The questionnaire question/answer schema and related tables have grown organically over time.  Originally it was built to handle one specific use case, security questions from spreadsheet questionnaires.

> Tl;dr - No big mistakes were made. The initial storage structure was developed based on the existing use cases and has expanded over time. However, with our increased domain knowledge and the emergence of new use cases we want to support, it's an opportune time to re-evaluate the storage structure.

> A lot of mixed domain data is represented at the top-level.  This can increase cognitive load making it hard to understand where it came from and what it is used for.

> While technically performant, the collection is complex.  There is a lot of data to manage in one place.

> A row for each suggested answer feels a little too granular, especially since we know we will only generate a finite number

> My north star recommendation is to move toward a data model like the one outlined in Option 2.

> We don't have to do this all at once.  As long as we know the end goal, this work can be accomplished in small chunks.  My suggestion would be to pick one of the features we want to work on (i.e. - storing custom multiple choice options) and start building that feature out with this design in mind.

> And we can use this doc as a callback in future Engineering specs to make sure we're still moving towards a sustainable data model.

## Working-with-me doc

> To solve a problem or get a question answered, I love hopping on a quick 5-10 min Zoom call.  I always feel like it's easier to iron out complex questions over dialogue.  But then I will be sure to summarize and share any decisions in Slack.

> I learn best by doing and I like to run through workflows that my team has, even if I'm not assigned to it on a recurring basis.
