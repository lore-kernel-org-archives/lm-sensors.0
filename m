From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 May 2008 12:23:46 +0000
Subject: Re: [lm-sensors] Call for 3.0.2
Message-Id: <20080512142346.2ae7f865@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080504200239.30be2ca1@hyperion.delvare>
In-Reply-To: <20080504200239.30be2ca1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 4 May 2008 20:02:39 +0200, Jean Delvare wrote:
> It's already over 3 months since we released lm-sensors 3.0.1. The list
> of changes isn't necessarily very long (which is expected, as the new
> libsensors was designed to not require frequent updates) but there's
> still some good stuff which should go public, such as the support for
> the ACPI thermal zones and the fixes to pwmconfig and fancontrol.
> Proposed schedule:
> 
> * May 11th: SVN freeze
> * May 12th to 17th: Testing
> * May 18th: Release

OK, the lm-sensors-3.0.0 branch in SVN is now frozen, only bug fixes and
documentation updates are allowed. We are now in the testing phase, so
everyone is welcome to test the daily snapshots and report how it goes:

http://dl.lm-sensors.org/lm-sensors-3/snapshots/

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
