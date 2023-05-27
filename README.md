# Mandarin Sandhify

Many tonal languages have a property called [tone sandhi](https://en.wikipedia.org/wiki/Tone_sandhi), whereby a tone will change in the context of another tone in an adjacent word. Native speakers tend to not even learn about tone sandhi and intuit it as they're growing up, but for people who're learning the language formally that's much more difficult.

Many of these tone sandhi rules are deterministic in Chinese, so you can create a parser to read some Pinyin text and transform it into something exact for pronunciation, something useful for language learners, which is what this tool does. Note that this project is incomplete and doesn't implement all the tone sandhi rules yet.

<sub><sub>When I started writing this I also thought there were a *lot* more tone sandhi rules in Chinese, but they really only extend out a lot when considering region-specific ones and dialects. So this is naturally pretty small, but I hope useful nonetheless. </sub><sub>

Ideally in the future it'll be turned into a web tool using Melange / ReasonML so that it's easy to use and serves as a quick reference. It's also possible in that case to leverage npm libraries to translate from Hanzi to Pinyin such that you can go straight from Hanzi -> an exact pronounceable form.

## Usage

First, install any dependencies with `dune`:

```
dune install
```

Then, build the program:

```
dune build
```

Then, run the program:

```
dune exec mandarin_sandhify
```