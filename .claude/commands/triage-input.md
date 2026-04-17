# /triage-input

## Purpose

Preprocess large or noisy input before deeper reasoning.

## Owned By

- Lead: `@master`
- Common support: domain specialist when needed
- Related skill: `triage-input`

## What It Should Do

1. classify the input shape and size before reading deeply
2. inspect the smallest useful slice first
3. extract the strongest signals first
4. recommend the next bounded step and the best next owner

## Output

- triage summary
- narrowed next step
- suggested handoff
