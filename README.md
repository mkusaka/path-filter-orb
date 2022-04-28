# Path Filter Orb


[![CircleCI Build Status](https://circleci.com/gh/mkusaka/path-filter-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/mkusaka/path-filter-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/mkusaka/path-filter.svg)](https://circleci.com/orbs/registry/orb/mkusaka/path-filter) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/mkusaka/path-filter-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)


This orb privides simple path filtering with two commands.
- continue: Continue if no change detected & stop if change detected.
- stop: Stop if no change detected & continue if change detected.

You can check usage & example at https://circleci.com/orbs/registry/orb/mkusaka/path-filter.

## Motivation
Currently, CircleCI officially provides [path-filtering orb](https://circleci.com/developer/ja/orbs/orb/circleci/path-filtering).

However, it must be invoked as a setup workflow and is therefore subject to setup workflow restrictions. For example, you cannot call a setup workflow within a setup workflow, so you cannot do another setup process after path-filtering.

Also, you need to learn a new setup workflow syntax.

This orb solves these problems
- Provided as a [Reusable config](https://circleci.com/docs/2.0/reusing-config/), so it is not affected by the setup workflow restrictions.
- It is provided as an orb, so if you are already familiar with orb, the learning cost is low.

There are also additional benefits
- The interface is created in a similar way to the path filter in github-actions, so if you are familiar with github actions, there is less learning curve.
- Simple implementation, so that user can copy its logic ealisy.

*This orb is not provided as an official circleci orb, so its use may be restricted in some orgs.
However, since the mechanism of this orb is simple, you can do almost the same thing by creating a reusable config like the following

```yaml
commands:
  path_filter:
    parameters:
      path:
        type: string
    steps:
      - run:
          name: filter by path
          command: |
            if [ ! $(git diff << pipeline.git.base_revision >>. << pipeline.git.revision >> --name-only | grep -E "<< parameters.path >>")]; then
              echo ci canceled due to no diff detected
              circleci-agent step halt
            fi
```

---

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/mkusaka/path-filter) - The official registry page of this orb for all versions, executors, commands, and jobs described.

[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using, creating, and publishing CircleCI Orbs.

### How to Contribute

We welcome [issues](https://github.com/mkusaka/path-filter-orb/issues) to and [pull requests](https://github.com/mkusaka/path-filter-orb/pulls) against this repository!

### How to Publish An Update
1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info mkusaka/path-filter | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/mkusaka/path-filter-orb/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.

### TODO
- add filter branch option such as [filters](https://circleci.com/docs/2.0/configuration-reference/#jobfilters)
