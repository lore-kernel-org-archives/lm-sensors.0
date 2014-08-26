From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 26 Aug 2014 16:37:26 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (lm90) split set&show temp as common codes
Message-Id: <53FCB7C6.8000503@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408948188-4181-1-git-send-email-wni@nvidia.com> <1408948188-4181-2-git-send-email-wni@nvidia.com> <53FB2AAA.30601@nvidia.com> <53FBF09F.8050502@nvidia.com> <20140826121729.GC15219@developer>
In-Reply-To: <20140826121729.GC15219@developer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Wei Ni <wni@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, khali@linux-fr.org, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/26/2014 06:17 AM, Eduardo Valentin wrote:
> On Tue, Aug 26, 2014 at 10:27:43AM +0800, Wei Ni wrote:
>> On 08/25/2014 08:23 PM, Mikko Perttunen wrote:
>>> FWIW, please fix the authorship information for next version.
>>
>> Sorry, I didn't get your point, did you mean I should remove the line
>> "From: lightning314 <wni@nvidia.com>" ? Yes I made a mistake on it, I
>> will remove it in next version.
>
> No Wei, don't remove the author line. Well, based on email, it is your
> patch, so, removing may satisfy.

The patch authorship should be fixed to have the correct value; 
"lightning314" is not a valid real name. In turn, depending on your git 
email configuration, this might automatically remove that line from the 
message, since it might then exactly match the email's from address.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
