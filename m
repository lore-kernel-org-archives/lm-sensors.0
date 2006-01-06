From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 06 Jan 2006 18:11:15 +0000
Subject: [lm-sensors] describe the patch flow, review process
Message-Id: <43BEB2C3.5050706@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


rather than just ask,  Ill guess (hopefully educated ;-)
pls correct / elaborate as necessary.


1.  Jean Delvare is main reviewer of patches here.
    he'd like help.
    half/baked reviews (like the one I just did ;-) are still better 
than none.
    if you give bad advice, youll get corrected,
    you'll learn more, and it wont hurt.

    the dialog will help you, the reviewee, and others
       And I cant resist a quote (boy, arent I clever ;-)
        from http://plato-dialogues.org/plato.htm

       Plato wrote *dialogues* rather than philosophy treatises, and, 
what's more, dialogues in which he never stages himself as a 
participant, it is because his purpose was not to tell his readers what 
/he himself/ thought, what were the answers /he himself/ had given to 
the most fundamental questions in life about *what it means to be a 
(wo)man*, but to teach them *to think by themselves*

    (see, talk is good !  It just has to go somewhere, not over same old 
'talking-points')

    Jean wont mind the 'extra' work of reviewing reviews
       its an 'investment' in a more vibrant lm-sensors community.
       (he still dreams about just playing freecell or Duke-Nukem  ;-)

2.   When Jean approves he:
    a. adds it to his http://khali.linux-fr.org/devel/i2c/linux-2.6/
            with comments in series file.
    b. sends it to GregKH for further review and occaisional pushback.
        that doesnt happen much, Jean is thorough.
             Greg's happy about that.
             Jean would be too.  See 1.

3.   Greg then
    a. puts them here ??  (I dont see them)
        http://www.kernel.org/pub/linux/kernel/people/gregkh/
    b.  pushes them to AKPM for inclusion in -mm
          does he consolidate them to 1 patch ?
             I think not, that would lose the attributions


and this is where I get a bit fuzzy.

2.6.15-mm1 came out recently  
    http://lkml.org/lkml/2006/1/5/149

but none of the stuff in 2.a  is there   (I looked for mine).

Is that because theyre going to Linus  / main / git  instead ?
and if so (not going to -mm)  why ?
        dont they warrant more testing / exposure there ?

Im not second-guessing here (hope thats obvious, but..)
just trying to understand, and more tothe point,
to know where to look, so I can check myself.  
(optimistically thinking here ;-)


Theres a less elaborate version of this at
    http://lm-sensors.org/wiki/FAQ
Ill update at some point, but wont mind if you do..

tia
jimc

