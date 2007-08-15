From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 08:31:44 +0000
Subject: Re: [lm-sensors] prog/dump/util.c is GPL version 2 only licensed
Message-Id: <20070815103144.32e3f33d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C0C758.5060509@hhs.nl>
In-Reply-To: <46C0C758.5060509@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 14 Aug 2007 22:52:32 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Now I realize that it probably doesn't make much sense to release just
> > one file with a different license, it hardly serves any practical
> > purpose and can only add to confusion. If it has any legal value at
> > all... So I am fine re-licensing that file if it makes you happy.
> 
> Yes, please relicense it.

Done.

>                           Most people don't realize it but once libraries GPL 
> v2 only code depends on become LGPL 3, then the GPL v2 only code can no longer 
> be distributed (atleast not as part of a distribution containing LGPL v3 
> versions of the libs the GPL v2 only code depends on).

I don't get it. You can link even closed-source code with
LGPLv2-licensed code (that was the purpose of this license over GPLv2).
Is this something that changed with LGPLv3? If not, how could you not
be allowed to link GPLv2 code then?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
