From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: [Fwd: xeontemp vs. adm1021]
Message-Id: <41097291.5050505@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4109462F.1060409@edgedesign.us>
In-Reply-To: <4109462F.1060409@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


That's consistent with the docs you mentioned earlier (xeontemp) which 
says that the 533 requires an external chip connected to the temp diode 
to read the temp.  It looks like that's what's happening here.

If you're really curious to see if the chips are indeed max1617 chips, 
you could pop the hood and try to find them.  It sounds like you've 
solved your mystery, though.


Phil

Steven Timm wrote:
> According to the Intel datasheet for the 533FSB Xeon they say that 
> they have a sensor diode embedded in the processor with two pins 
> available to access it.  According to the Supermicro X5DPA-GG 
> documentation they claim to have a sensor chip that can read that,
> although I don't have the technical documentation to prove that it
> is indeed a max1617 type chip.. it is likely that whatever I'm 
> reading is hooked up to the internal temperature diode.
> 
> Steve
> 
> 
> ------------------------------------------------------------------
> Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
> Fermilab Computing Division/Core Support Services Dept.
> Assistant Group Leader, Scientific Computing Support Group
> Lead of Computing Farms Team
> [...]
