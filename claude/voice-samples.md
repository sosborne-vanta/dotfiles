# Scott's writing samples

Verbatim excerpts, grouped by where they were written, chosen from about 1,000 review comments (Oct 2024 to May 2026), hand-written PR descriptions, eng specs, and the North Star doc. Spacing, casing, and typos are his. Use these to calibrate `voice.md`; don't quote them.

## Short approvals and reactions

> lgtm

> qauto approve

> trust center approve

> re-approve

> thanks for the video.  approach looks good

> Let's get it in.  We can iterate on content in the future!

> a couple small suggestions, but ready to try it out

> This looks good.  Test cases look good.  lets do it

> Love it!
>
> I did some click testing on a local branch and everything was looking good.  Attempted deep links and clearing local storage and cache and everything was loading fine.

> 🔥 This is great!  We can make small refinements later as we start to use more real-world data!

> Phew, a lot of tests!  I skimmed through them and they looks appropriate to me.
>
> This should be good for now.  We can test the actual notification via RedPanda on staging after it is deployed.

> dang, that ended up being more annoying (with all the test changes) than I thought it would be.  Thanks for working through it!

> wow, i'm not sure when this would happen, but seems fine to me

> OOF, big prompt change, thanks for doing lots of testing

> Bummer that we have to define descriptions on both the Input type and the route params.  Left one nit, but it's not a huge deal.

> It's mind-boggling how many copies of the same enum we have.... 🤦

> I'll ✅ to unblock, but let's remove the enums and make the type declarations consistent

## Review summaries with an ask

> Thanks for doing this @colortheskyjade!  Looks like a big improvement!  Left some thoughts from my quick read-through. Nothing blocking.

> Looks good.  I had a couple small nits about naming, but nothing big.
>
> I regression tested locally to make sure the CSV export still worked as is.

> I think this is good to go, but I would do one last check on the styling, the screenshot looks like the spacing is too wide between the title and subtitle, here's the protokit

> Looks good, a few small nits.  Feel free to do now or in a follow-up

> Left some comments.  I think we should take one more pass at this to clean it up a little.

> Let's take another pass at this @elliedori.  If you want to meet up to spitball some ideas, let me know.

> Let's not bother.  Now that we've fully launched object roles for ownership, I will work on a cleanup PR just to remove these operations.  But I need to check the front-end first.
>
> I added a story for myself: https://vanta.atlassian.net/browse/CTAUTO-434

> This code looks good to me.  Would be nice to add one more test and see a Loom of it working IRL.
> (I see you tested it with CURL, which I trust, Loom just add's another layer of confidence)

> I know this is on a tight timeline, so I don't want to introduce too many cycles.
>
> I'll approve this as is.  But if there is time now or later, i would suggest some refactors just to reduce scope in this large component.

> Ideally, we should separate back-end and front-end changes (web and web-client).  But I think this feature (answer history) is still gated by a feature flag, yes?
>
> It's probably fine in this use case as it's a new, not commonly used surface, but going forward, let's do our best to always separate FE and BE changes.

> The lift looks fine.
>
> I'm not totally understanding why we're building separate front-door files for all the REST operations. Why aren't these just normal front-door operations?

> I'm a little dubious of needing an extra status variable on every response object, but if we have good patterns for keeping it in sync with the actual data, and it provides some future flexibility, then I'm ok with it.

## Inline: quick and direct

> This already exists somewhere else, reuse it

> This should utilize .loadMany instead of the promise.all

> Should not be performing direct mongo actions in the job, put this method into the questionnaireSectionService or the questionnaireResponseService

> gotta remove this line

> message needs updating

> nit: naming
> ```suggestion
> export const getSortedQuestionnaireResponsesForResponseIds = async (args: {
> ```

> nit: would prefer named parameters

> nit: use createStrictSchema instead

> same here: createStrictSchema

> Don't forget to migrate this one too!

> 100 feels pretty large for an autocomplete.  I would imagine 20-25 should be plenty.

> Let's keep it simple, see toast guidelines: https://alpaca.supernova-docs.io/...

> +1

## Inline: thinking out loud

> Hmm... the registry entry defines the auth method... but it still feels like there's something missing here.
>
> The auth is still check for the provided resources in this method.  Maybe that check should be described here.

> I think this may have already been added to the TrustReport GQL object directly??
>
> Actually, looks like that's also in my PR that is in the merge queue [here](...)

> OK, go ahead with this one.  I thought there was already a hook in the front-end somewhere for this... but I also can't find it.  Ideally, it would just be defined in a shared helper.

> I'm confused how this works?  Isn't this circular?  Don't we use this file to define the route availability?

> nm, I read the doc.  I guess this is redundant because there is another index at the bottom of the file for: ... where domainId is the first prefix.

> I think I'm a little confused here.  Why wouldn't this just be anytime channelChanged = true?
>
> Doesn't the normal 'target channel' functionality even without auto-reply post new messages in that target channel and need to join?

> Interesting, that's kind of how I would expect 'cache-and-network' to work, but sounds like you're saying the component is re-mounting without the page actually reloading, so it had some stale data in the cache

> hah, ok.  Sorry, I didn't get the excel reference 🙌🏻  Mostly just peaked my interest because it wasn't camelCase.  But I do think using 'index' in the name is clearer.

> this syntax is mindboggling...

## Inline: pushback with the why

> This still feels like a pretty big code smell that we have to do a manual cache evict here.  Can you explain the root issue a little better?

> I don't think this PR is right.
>
> 1. We shouldn't ever have to add an index on `_id` because it's the unique index on the table and I it has a built-in index.
> 2. The query he mentioned in the thread was on the questionnaireResponses collection, not the questionnaires collection ([here](...))

> What's wrong with using the data loader right above this, `getSortedQuestionnaireResponsesForResponseIds`?
>
> I understand that this projection is technically selecting less data from the database, but until we have an actual problem, I'd prefer to re-use existing code paths instead of over-optimizing.

> I don't think we should log and return default here... that could result in some hard to debug behavior.  If the store is required, then we should just make it required for the repository.

> Since it will be an external service that we have to maintain for backwards compatibility, let's start with less fields until they're needed.

> I'm leaning toward the best code is no code approach and would rather remove these from this mutation as soon as we update the edit modal component.

> nit: Would prefer this in a new util file like /packages/trust/src/qauto/questionnaire/utils/questionnaireSections.ts
>
> just to not bloat this '/service' folder, trying to eliminate unnecessary files out of here, so it's not just a junk drawer

> The repository class should still be thought of as just an interface and agnostic to Mongo specifically.  So I think this translation of the input type to the actual MongoDoc type should happen in the Mongo implementation of the repo class itself.
>
> I know it's kind of subjective, but that's the idea, mongo specific translations remain in the mongo specific repo implementation.

> This probably works for now because we only allow one configuration for the whole sheet.  I think there is a future world we we allow more custom configuration per row.  But we can cross that bridge when we come to it.

> I'm happy to jump on a call to resolve this.  Also happy to just move forward with whatever you decide.  I think all the approaches have trade-offs and they're not 1 way doors.  We can continue to iterate on this code as we move forward.

## Inline: scoping and deferring

> This is probably a fine default for now.  If you look down below, this endpoint is actually doing an auth assert on `canViewActors` and `canViewOwnedObjects`

> Not a blocker to this PR per se, just curious.

> No reason to change it right now.  This is a simple solution and I know you're solving a specific problem.  Just wanted to share my 2 cents.

> Could be a design follow-up

> I think @donton wanted a limit on this, like up to 3 tab names, but over that, it says something like "Pricing, Docs, and 2 more tabs")

> Looks ok to me, but I'll let @emadkhan give it a final stamp since he worked on this code recently.

> I guess looking further, I see both patterns, so either is probably ok.  Maybe @zabrador has an opinion.

> Probably good to think about the error scenario.  We can throw and have an onError handler on the front-end to tell them the responseId was not found.
>
> Check in with Dorna to see what she thinks.

> But ultimately, we should do something like what KB Resources does [here](...) and build a custom permission set for the combined set of selected resources.  Then we can use ReBAC checks for this full set of selected items.  I created a follow up story [here](...)

## Inline: evidence and testing

> I tested on a qauto-basic account and was able to see/access these statuses, which shouldn't be the case.

> OK, I checked the db on local and staging and didn't see any entries for 'Automatic'.
>
> But it probably would be good to remove this from the backend enum as well ([here](...))

> In the preview env, it seems to work ok when you're on the first page, but when on the second page, it resets paging back to the first page.

> NM, this is a pre-existing bug on staging... 😮‍💨

> Checked out the [NPM page](...)
>
> Not huge usage, but 0 dependencies, MIT license, and recent-ish dev activity.

> Also, going forward, can you provide a screenshot or loom of your testing to help reviewers validate your results?  Thanks!

## PR descriptions (hand-written)

> ## Changes
>
> Interpret quick view filters correctly for the NEEDS_MY_APPROVAL option and pass correct options down to pagination service
>
> ## Motivation
>
> [Bug bash](...) identified that the filter wasn't working correctly for assigned approvers.
>
> ## Deployment
> no flag needed, forward fix, revertible

> This second PR is part of the strangler fig pattern. The first PR replaced the inner logic of the existing methods with calls to the new service.  This PR replaces the actual usages of the deprecated methods with direct calls to the service. Then deletes those unused methods.

## Eng spec and North Star prose

> We're having trouble with various background jobs not fitting neatly into the core-platform SLO expectations.  Many of our background jobs incorporate AI calls or 3rd party service calls that utilize AI.  And these processes can be variable depending on the query and size of the data.

> The access request team created their own collection to store slack message data with the context they care about.  It is pretty close to being generic, but has an accessRequestId specific to their entity. We could create our own collection similar to this and potentially merge them into a more generic version in the future.

> Only for single question notifications?  Maybe we trigger it all the time since we won't necessarily know without looking it up

> Tl;dr - No big mistakes were made. The initial storage structure was developed based on the existing use cases and has expanded over time. However, with our increased domain knowledge and the emergence of new use cases we want to support, it's an opportune time to re-evaluate the storage structure.

> A lot of mixed domain data is represented at the top-level.  This can increase cognitive load making it hard to understand where it came from and what it is used for.

> A row for each suggested answer feels a little too granular, especially since we know we will only generate a finite number

> My north star recommendation is to move toward a data model like the one outlined in Option 2.

> We don't have to do this all at once.  As long as we know the end goal, this work can be accomplished in small chunks.  My suggestion would be to pick one of the features we want to work on (i.e. - storing custom multiple choice options) and start building that feature out with this design in mind.

## Working-with-me doc

> To solve a problem or get a question answered, I love hopping on a quick 5-10 min Zoom call.  I always feel like it's easier to iron out complex questions over dialogue.  But then I will be sure to summarize and share any decisions in Slack.
