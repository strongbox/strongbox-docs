# How To Gather Requirements And Keep Issues In An Easy For Handover State

Gathering requirements is of key importance when you need to plan, organize and distribute work. When raising issues and tasks in an issue tracker, it's important to be able to describe in a clear and concise way what needs to be done, so that anyone in the team could pick up the work and have as much information and resources, as necessary in order to be able to work out the finer details independently.

When the overall duration of the task is estimated to be long, it's important to have clarity on what the list of sub-tasks is and to keep the progress visible, so that others could join in and easily help push things forward without overlapping efforts, or the need for lengthy explanations on how they can help. This could be crucial, if the completion of the task is required in a significantly shorted time-frame. Also, as we all know, everything happens in life (people get, go on vacation, or quit) and without such clarity, it would take an additional effort to evaluate the progress of the task, should the original assignee be re-assigned, or not be able to complete the work.

For smooth development we need to be able to have two things:
* A stable `master (building fine without failing tests)
* Continuity in case someone falls sick, has finished working on the project for the day, or next few days and has either broken the `master`, or been in the middle of an urgent investigation that someone else will need to continue in their absense

This is a short list of things to keep in mind when gathering requirements, so that they could be well defined and easy to handover:

* __*(Recommended)*__ Make a rough outline of a the problem (use bullet points to force yourself to be brief, but at the same time try to provide a sufficiently clear explanation)

  * As soon as you have gained an initial understanding of the overall task, try to outline the main parts of the work that needs to be done, so that you could later dive into the the finer details.

* __*(Recommended)*__ Expand on each bullet point with sub-points, until the amount of detail is sufficient, but stick to the point and don't add excessive details

  * This will help improve the understanding of what needs to be done and provide more granularity.

* __*(Recommended)*__ Outline the points of contact (requested by, SME(s) on this topic, mailing lists, forums)

  * This will help you find more information, or get hints.
  * Feel free to ask questions on Stackoverflow, there are many people out there who could help, or provide a different angle to view things from.

* __*(Recommended)*__ Gather a list of useful links

  * This is extremely important for continuity and handovers, as it will help others get up to speed with what you already know.

* __*(Recommended)*__ Gather a list of documentation resources that will need to be updated, (if any)

  * Our documentation needs to be continuously improved and we can't rely on others documenting things for us.

* __*(Recommended)*__ Link related tasks

  * When you have related tasks, this helps keep track of what needs to be done as next steps in order to complete a certain feature and not lose track of the follow-up tasks.

* __*(Recommended)*__ Outline the testing strategy, (if any)

  * This will help understand what needs to be checked in order to consider the fix, or feature ready for merging.

* __*(Optional)*__ Have a brief "definition of done"

  * Some tasks might not involve testing and this would help understand where to draw the line and consider the work finished.
  * Sometimes a task needs more work after the testing phase is complete. For example, you might need to switch, or updated URL-s, trigger a build of another project, or something else along these lines. In such cases, this sort of section would be quite useful.

* __*(Recommended)*__ Use task lists to tick out things that have been done and what you're working on (by either adding a comment next to the task, or putting `(in progress)` next to it, so that there is clarity where the overall task
  stands and how it's progressing
  
  * Doing this allows everyone to have an understanding of what exactly is finished and where a given task stands.
  * It helps identify parts of the overall task where others can join in and help speed up the progress.
  * This also helps maintain a good morale, as there is a psycholofical aspect to it: if your task list consists of three tasks that take six weeks, it might seem that you're stuck, or not progressing, when, in fact you've actually done fifty tasks which nobody knows (or will ever know) about. If you had added those tasks to the check list, it would be apparent how much work you have really done and you will be able to show it clearly.
  * It's up to you what you add to this check list. Try to add visible tasks, but don't be excessive and add tasks that would take extra small/trivial tasks that'll take five-ten minutes to do.
  
* __*(Recommended)*__ When the requirements are gathered, identify the larger pieces of work and split them into new tasks, if necessary
  (repeat the requirements gathering process and apply it to them as necessary)
  
  * As work progresses on a given task, sometimes new requirements pop up that will increase the time required to complete. When it makes sense, extract the work into separate new tasks.
  * Keeping the overall task as something easy to achieve, improves the morale, as it increases the sense of achievement.
  * Lenghty tasks have the following undesired side-effectsL
    * Reviewing the code will take a while
    * You might have to rebase several times and waste time resolving conflicts
  
* __*(Recommended)*__ Continuously add useful commands and output (when working on the task)
  
  * This will help other people join in and help you, or continue your work, if necessary.
  * It will also help you not waste time to figure out that three line script you knocked up yesterday that you used to check some data.


