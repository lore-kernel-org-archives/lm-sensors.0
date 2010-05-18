From: Carsten Emde <C.Emde@osadl.org>
Date: Tue, 18 May 2010 07:13:07 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current
Message-Id: <4BF23E03.40902@osadl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100510035031.GD9181@owl> <20100514065808.GA11598@owl> 	<20100517094136.094800562@osadl.org> <AANLkTinQlH7LhCAz00WaHqbbslcSqipzVx4tDoQKSqIL@mail.gmail.com> 	<625BA99ED14B2D499DC4E29D8138F150181F574C31@shsmsx502.ccr.corp.intel.com> <AANLkTimQnaUvXs75rpTOcW7CODXWgUfzekY9FCDa5S8P@mail.gmail.com>
In-Reply-To: <AANLkTimQnaUvXs75rpTOcW7CODXWgUfzekY9FCDa5S8P@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Gromov <gromovd@gmail.com>
Cc: "Wan, Huaxu" <huaxu.wan@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On 05/18/2010 08:45 AM, Dmitry Gromov wrote:
> On Tue, May 18, 2010 at 01:07, Wan, Huaxu<huaxu.wan@intel.com>  wrote:
>> The TjMax of N270 is 90C, according the official documents [1][2].
>> [1] http://ark.intel.com/Product.aspx?id6331&processor=N270&spec-codes=SLB73
>> [2] http://download.intel.com/design/processor/datashts/319977.pdf
>> Thank you, this is exactly why I'm asking. I think, "guessing" values here
> can be dangerous - who knows what critical apps they will relied upon.
Yes, of course. I never wanted to use a guessed and not documented
value. I only wanted the temperature reading to be plausible.

> And 90C seems to be good for N200 series of Atom CPUs only - I could not
> find TjMax value published for N330 Dual Core  (quite popular one). Intel
> only published Tcase for it:
> http://ark.intel.com/Product.aspx?id5641
> So, if for N270 Tcase = TjMax = 90C, then, I'd suggest to use Tcase = 85.2C
> for N330 TjMax value.
They have the same CPU model ID:

# grep model /proc/cpuinfo
model		: 28
model name	: Intel(R) Atom(TM) CPU N270   @ 1.60GHz

# grep model /proc/cpuinfo
model		: 28
model name	: Intel(R) Atom(TM) CPU  330   @ 1.60GHz

I would like to propose to use the patch as it is. It's the best
version we ever had.

	Carsten.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
