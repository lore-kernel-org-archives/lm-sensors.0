From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Your e-mail to Europe.Support@nsc.com
Message-Id: <20030723160650.5ba7cdc8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722114420.2191c700.khali@linux-fr.org>
In-Reply-To: <20030722114420.2191c700.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Thanks a lot for your answer, it's slightly clearer now. However, I fear
it's not enough for the needs we have.

Maybe I've not been clear enough about the finality of my questions. We
are writing a detection program. The program is intended to be run by
thousands users worldwide. These users use our program because they
don't know which sensor devices they do have on their computer system
(mainly motherboard, sometimes video card too). Most hardware
manufacturers don't mention that kind of information on the
documentation, and that's why a detection program is needed.

Understand me, we do not have all these devices ourselves. That's why we
can't just read from the registers to see which values are reported, as
you suggested. We would have done so instead of annoying you if we
could, but we just don't have any LM81, LM83, LM86, LM89 not LM90
ourselves. However, we would like our detection program to know about
them, so that we can tell our users if they have such devices (and then
we can write a driver for them, using your great PDF datasheets).

That's why we really would like to know as much as possible about
steppings/die revision codes. Especially, the complete lack of
information for the LM83 makes it impossible to support at the moment
(any other device could be misdetected as a LM83). The lack of range end
for the other devices is no so problematic, however having an idea about
these would be great.

So I have to ask you again for an answer to the two following questions:

1* What are the possible LM83 die revision codes? (very important) This
information really should be present on the LM83 datasheet, methinks.

2* To what extent can the other devices ID be incremented? (less
important)

I really would like you to take some time to find this information. We
need this to support your devices better. I understand that these
questions are not the ones your customers are usually asking, however
there must be a way you can bring this information to us. You are
National Semiconductors after all, so if you can't help us about the LM
sensor chips, who on Earth will be able to? If you really can't answer
my questions, please at least give us the e-mail address of someone at
National Semiconductors who you think will be able to help us.

Thank you very much for your time and assistance.

Jean Delvare


> Dear Mr. Delvare,
> 
> Please find below the answer given to your request by one of our
> engineers:
> 
> 
> * LM81
> > The datasheet is unclear about the stepping (register 0x3F). The
> > comment says the revisions will start with 1, but the power-on
> > default is said to be "0000 0011", that is, 3. Which value should we
> > trust?
> 
> The first revision is numbered 1, second 2 and so on. In this case,
> the power on value is 3 because its the 3rd revision device.
> >
> > * LM83
> > No stepping value is given for the LM83. Can you give us the
> > possible values?
> 
> I dont have any values for this either. These numbers are purely for
> traceability, you can read to register to find out the value.
> >
> > * LM86, LM89, LM90
> > The datasheets say the die revision codes start at 0x11, 0x31 and
> > 0x21 respectively, and will increment by one everytime there is a
> > revision to the die. To which extent can the die revisions be
> > increased? Are the whole 0x11-0x20, 0x31-0x40 and 0x21-0x30 ranges
> > used?
> 
> Again I dont know how many revisions of each die there have been but I
> doubt the full ranges have been used.
> I'm sorry I cant give any more information but the revision codes are
> generally not requested or needed by customers. They are primilarly
> there for traceability reasons."
> 
> Kind regards
> 
> Ulrike Mayer,
> 
> National Semiconductor
> The European Customer Response Centre
> English :       +44 (0) 870 2402171
> Deutsch:        +49 (0) 69 95086208
> Francais:       +33 (0) 1 41918790
> Europe Fax:   +44 (0) 1756 702889
> 
> E-mail:    europe.support@nsc.com
> Internet:   www.national.com
> 
> 
> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: 22 July 2003 10:44
> To: Europe Support/Europe/NSC
> Cc: LM Sensors
> Subject: Re: Your e-mail to Europe.Support@nsc.com
> 
> 
> > To help us dealing with your request immediately, please use REPLY
> > WITH HISTORY when responding to this email.
> > *******************************************************************
> > *******************************************************************
> > *********************
> >
> > Dear Mr. Delvare
> >
> > Thank you very much for your request and your interest in our
> > products.
> >
> > Understanding your business, job function and product interest will
> > help us to offer information tailored to your specific needs. We
> > would therefore appreciate a moment of your time to complete the
> > database profile below.
> >
> > We thank you very much in advance for your assistance.
> >
> > Contact Details
> >
> > Your Name
> 
> Jean Delvare
> 
> > Your Jobfunction
> 
> Software Developer
> 
> > Your Department
> 
> Linux
> 
> > Company
> 
> Not a real company. I am working for the LM Sensors project. We bring
> support of your LM sensor chips (amongst others) to Linux.
> 
> > Street
> > Post Code
> > City
> > Country
> > Phone (direct line)
> > Fax
> 
> Irrelevant here. We are an international team of distinct individuals.
> 
> > Email
> 
> sensors@stimpy.netroedge.com
> 
> > *******************************************************************
> > *******************************************************************
> > *********************
> >
> > Who is your preferred distributor?
> >
> > You prefer technical information on (please indicate the appropriate
> > option below):
> >
> > * CD ROM
> > * Databook
> > * WWW
> 
> WWW, definitely. Your PDF datasheets are really great.
> 
> > *******************************************************************
> > *******************************************************************
> > *********************
> > Project Details:
> >
> > What is the name of the project?
> 
> LM Sensors.
> 
> > What is the end application?
> 
> Monitoring the hardware health of Linux systems.
> 
> > When do you plan to go into production?
> 
> We already are.
> 
> > What is your expected / current production volume for this project
> > per year?
> 
> Really hard to evaluate, since we don't sell our product. However, the
> user base is really large. Our website gets 1500 hits/day, the number
> of regular users is estimated to 10000.
> 
> > *******************************************************************
> > ******************************
> >
> > Thank you very much for your time. We appreciate your co-operation
> > in this matter.
> >
> > Kind regards
> >
> > Ulrike Mayer,
> >
> > National Semiconductor
> > The European Customer Response Centre
> > English :       +44 (0) 870 2402171
> > Deutsch:        +49 (0) 69 95086208
> > Francais:       +33 (0) 1 41918790
> > Europe Fax:   +44 (0) 1756 702889
> >
> > E-mail:    europe.support@nsc.com
> > Internet:   www.national.com
> >
> >
> > ----- Forwarded by Patricia Randklev/Americas/NSC on 07/21/03 10:55
> > AM-----
> >
> >
> > Please provide a detailed explanation of your technical question?
> > Die revision codes
> >
> >
> >
> >
> > Your Email        khali@linux-fr.org       Submission Type:
> >
> >
> >
> > Hello,
> >
> > I am working for the LM Sensors project, which is an effort of
> > building and providing some essential tools for monitoring the
> > hardware health of Linux systems. You may take a look at our project
> > page there: http://www.lm-sensors.nu/
> >
> > Amongst many other tools, we have one that detects the sensor
> > chipsets on I2C busses. In order to have reliable detection
> > routines, we need to know as much as possible about sensor chipsets
> > than can be found in PCs. The datasheets available on your website
> > are very great and useful, but unfortunately some details are
> > unclear or missing. Here are some questions I would very like to
> > have answers to. This would make our support for your chipsets
> > better.
> >
> > All questions are aimed at the "stepping/die revision code"
> > register.
> >
> > * LM81
> > The datasheet is unclear about the stepping (register 0x3F). The
> > comment says the revisions will start with 1, but the power-on
> > default is said to be "0000 0011", that is, 3. Which value should we
> > trust?
> >
> > * LM83
> > No stepping value is given for the LM83. Can you give us the
> > possible values?
> >
> > * LM86, LM89, LM90
> > The datasheets say the die revision codes start at 0x11, 0x31 and
> > 0x21 respectively, and will increment by one everytime there is a
> > revision to the die. To which extent can the die revisions be
> > increased? Are the whole 0x11-0x20, 0x31-0x40 and 0x21-0x30 ranges
> > used?
> >
> > Thanks a lot for your help and time.
> >
> > --
> > Jean Delvare
> > http://www.ensicaen.ismra.fr/~delvare/
> >
> >
> >
> >
> >
> >
> >
> >
> 
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 
> 
> 
> 
> 
> 
> 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
