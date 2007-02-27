From: pinkel@gmail.com (Ivo Manca)
Date: Tue, 27 Feb 2007 10:59:03 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <007401c75a5e$4cc3e240$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

First of all, sorry for my late response.

> I've read the "Background Information" and "Objectives" parts, overall
> it looks good, except that a proofread of the document would be very
> welcome.

We've tried to fix most of the errors and typo's in the document before 
sending in to the mailing list. However, English is not our main language 
and because of our school's short time limit there still may be some errors. 
Thanks for noticing it, we will check the document again and post an updated 
version as soon as possible.

> My comments:
>
> * The primary objective mentions an "internal database". I'm not sure
> what "internal" is supposed to mean here. Do you plan to embed a big
> array of known motherboards inside the sensors-detect script itself?

In this case, internal means that the database is stored on the user's 
computer. The reason we mentioned this is because we first considered an 
option which makes the script connect to the corresponding website. This 
however does not seem to be a very welcome "feature".

The actual place were the database will be stored is not yet decided.

> * I'm very much in favor of command line parameters being added to
> sensors-detect so that for example a non-interactive mode can be
> supported. I wanted to do that myself for some time but could never
> find the time to actually do it. Another useful mode would be a "quiet"
> mode, which would hide all the details and present the probing summary.
> It would still be interactive in that it should not overwrite the
> configuration file without the user's consent, so it would be somewhat
> intermediate between the current mode and a fully automated mode.

It seems that this did not end up in the final version of the project plan 
but this was also our view.
The command line switches we were thinking of adding, include:
* An automatic (or: non-interactive) mode, which will only use the DMI 
information to detect the sensors.
* A mode which first uses the DMI information and then asks whether or not 
the user wants to probe afterwards.
* A probing-only mode. For various reasons it might be welcome to keep this 
mode, for example: if for some reason the DMI information is bogus.

This automatic mode could also be very useful for newly installed 
configurations. In this case the user will already have a configured 
sensors.conf and is able to use the software "out-of-the-box". However, this 
is just a thought.

We've already figured out that the default option of sensors-detect should 
not overwrite an existing configuration file without asking first. It might 
give some frustration to the users..

> BTW, I think you really mean "first objective" and "second objective",
> not primary and secondary.

We meant: "Most important" and "Less important". I thought primary and 
secondary was a correct translation for this. They both still need to (and 
will) be completed though.

Ivo Manca 


