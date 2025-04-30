### 2025-04-29: `chrivers/predictable-deterministic`

Manually impl Hash for RType, to maintain predictable output

if at all possible, RType::deterministic() should produce the same uuid in later versions of Bifrost as the current one.

If not, everybody will see bad artefacts such as the infamous duplicate group issue, that has happened a few times by accident - and now we found out why.

When reordering (or indeed just adding/removing) a variant of RType (Room, Scene, etc), all following variants would get a new index, and this meant a new hash.

Now Hash is implemented manually, and a regression test has been added to prevent future accidents.
