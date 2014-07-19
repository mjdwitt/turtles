TURTLES
=======

A silly stack language.

         _.._    _ 
       ."\__/"./`_\
     _/__<__>__\/  
    `"/_/""""\_\\  

(Art credit to `jgs` via 
[retrojunkie](http://www.retrojunkie.com/asciiart/animals/turtles.htm))



## Related Work (Or: I have no clue what I'm doing here)

There are plenty of other stack-based languages out there, most notably Forth.
That said, I've never used any of them. Moreover, I only have the loosest 
understanding of how they work and I haven't even bothered to verify that. In 
short, whatever you find here is probably terrible and should never be used for 
anything real by anyone, ever.

That said, here are a few things that came up when I googled for lazy stack 
languages: [Cat](http://www.cat-language.com/) and [Lazy 
Prefix](http://esolangs.org/wiki/Lazy_Prefix). If you find yourself here on 
accident, those are probably what you're looking for. I think. Because I didn't 
bother reading anything beyond the first couple paragraphs on either of those 
pages. Please please please don't take this project seriously.



## My dumb idea

What follows is a brain dump that I've had running in an empty buffer for 
a couple days while I think about this. The gist of this project is that I felt 
like making a stack language, then I decided to make it lazy, and I'll probably 
continue to have stupid ideas that I'll cram into and subsequently rip out at 
a later time. Anyways, here's my dumb idea:

---

Assume I have some sort of environment worked out. Given that, I'd like to
define new words by placing some anonymous block on the stack followed by a
symbol and then the define word that will associate the symbol and block in the
environment.

Defining blocks becomes extremely simple when you have a *lazy* stack language.
I think. And turtles is a **great** name for a lazy stack language.

So, lazy stack evaluation. Basically, we'd need operators to force evaluation.
How about `.`? I think that meant print in Forth, but I'm pretty blatantly
*not* reading prior literature here. So sure, `.` can be force. Specifically, it
ought to take the first item on the stack and run it on the rest of the stack.
Without `.`, nothing ought to happen. Well, how about we just return the
unevaluated stack? So,

    21 2 *
    => 21 2 *
    21 2 * .
    => 42

We'd want to handle evaluating the empty stack. So we should make the empty
stack `nil` and cause popping it to return `nil` and leave the stack at `nil`.
Then,

    .
    => nil

Even better, how about we just always return the stack, and then `.` can just
eval the top value with the stack and place it's answer back on the stack.

    1 2 3 + .
    => 1 5

With this, creating a block could be done with two predefined words, `{` and
`}`, like so:

    { 2 3 + } .
    => { 2 3 + }
    7 { 3 } .
    => 7 { 3 }

So, symbols could be made from bare words and a symbol constructor word.

    a-word : .
    => :a-word

Wait, if everything is lazy, we don't even *need* symbols, we can just use bare
words when defining. That is,

    42 the-answer def .

would associate `the-answer` with `42` in the environment.

And about that environment... I bet we could just treat the stack itself as the
environment by searching the stack for evaluated `def`s whenever we encounter
a bare word. Then...
