From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Fw: Your e-mail to Europe.Support@nsc.com
Message-Id: <20030723154040.5d880fe9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722114420.2191c700.khali@linux-fr.org>
In-Reply-To: <20030722114420.2191c700.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



(Looks like it will be hard to get interesting information from this
person... I will try once again anyway.)

Begin forwarded message:

Date: 23 Jul 2003 04:12:44 -0700
From: "Europe Support/Europe/NSC" <Europe.Support@nsc.com>
To: khali <khali@linux-fr.org>
Subject: Re:Your e-mail to Europe.Support@nsc.com


Dear Mr. Delvare,

Please find below the answer given to your request by one of our
engineers:


* LM81
> The datasheet is unclear about the stepping (register 0x3F). The
> comment says the revisions will start with 1, but the power-on default
> is said to be "0000 0011", that is, 3. Which value should we trust?

The first revision is numbered 1, second 2 and so on. In this case, the
power on value is 3 because its the 3rd revision device.
>
> * LM83
> No stepping value is given for the LM83. Can you give us the possible
> values?

I dont have any values for this either. These numbers are purely for
traceability, you can read to register to find out the value.
>
> * LM86, LM89, LM90
> The datasheets say the die revision codes start at 0x11, 0x31 and 0x21
> respectively, and will increment by one everytime there is a revision
> to the die. To which extent can the die revisions be increased? Are
> the whole 0x11-0x20, 0x31-0x40 and 0x21-0x30 ranges used?

Again I dont know how many revisions of each die there have been but I
doubt the full ranges have been used.
I'm sorry I cant give any more information but the revision codes are
generally not requested or needed by customers. They are primilarly
there
for traceability reasons."

Kind regards

Ulrike Mayer,

National Semiconductor
The European Customer Response Centre
English :       +44 (0) 870 2402171
Deutsch:        +49 (0) 69 95086208
Francais:       +33 (0) 1 41918790
Europe Fax:   +44 (0) 1756 702889

E-mail:    europe.support@nsc.com
Internet:   www.national.com


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
