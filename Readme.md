## Recipe ID library

This library provides a remote interface for mapping recipes to unique integer IDs, for use in circuit networks.

The entire map may be retreived by `remote.call('recipeid','get_recipemap')`, and provides indexes by both recipe name and id.
Individual lookup may be performed by `remote.call('recipeid','map_recipe','recipename')` or `remote.call('recipeid','map_recipe',42)`.
