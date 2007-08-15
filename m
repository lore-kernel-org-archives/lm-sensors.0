From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 15 Aug 2007 09:06:11 +0000
Subject: Re: [lm-sensors] prog/dump/util.c is GPL version 2 only licensed
Message-Id: <46C2C203.3010601@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C0C758.5060509@hhs.nl>
In-Reply-To: <46C0C758.5060509@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Tue, 14 Aug 2007 22:52:32 +0200, Hans de Goede wrote:
 >
>>                           Most people don't realize it but once libraries GPL 
>> v2 only code depends on become LGPL 3, then the GPL v2 only code can no longer 
>> be distributed (atleast not as part of a distribution containing LGPL v3 
>> versions of the libs the GPL v2 only code depends on).
> 
> I don't get it. You can link even closed-source code with
> LGPLv2-licensed code (that was the purpose of this license over GPLv2).
> Is this something that changed with LGPLv3? If not, how could you not
> be allowed to link GPLv2 code then?
> 

Well, I'm not a lawyer, but both Fedora's (RedHat's) and the FSF lawyers
have looked at this. Below is my understanding of the issue as explained to me.

The problem is the following section of the GPL:

---

The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.  However, as a
special exception, the source code distributed need not include
anything that is normally distributed (in either source or binary
form) with the major components (compiler, kernel, and so on) of the
operating system on which the executable runs, unless that component
itself accompanies the executable.

---

The problem lies in the "complete source code means all the source code for all
modules it contains", which should be translated as "the source for the program
+ all libraries it uses", This is there to stop people from taking a GPL app
putting new interesting stuff in a lib and then ship the app with source with
bindings to the lib, but the lib with the new stuff itself under a proprietary
license. So the source for all libraries must be shipped, and must be shipped
under a GPL version 2 compatible license. LGPL 2 is GPL version 2 and GPL
version 3 compatible, so using LGPL 2 libs (or BSD libs) is fine for a GPL
version 2 app, but LGPL 3 will only be GPL version 3 compatible not GPL version 2.

Thus when a library used by a GPL version 2 only app becomes LGPL 3, that app
can no longer be distributed, because we no longer distribute all the needed
libraries under a GPL 2 compatible license, as is demanded by the GPL version 2.

I hope this clarifies things.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
