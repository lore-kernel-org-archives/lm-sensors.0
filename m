From: Micah Gersten <micahg@ubuntu.com>
Date: Fri, 17 Jun 2011 17:04:41 +0000
Subject: Re: [lm-sensors] sensors-detect won't recognize 3.0 kernel
Message-Id: <4DFB8929.4030804@ubuntu.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DF6F1CD.9030001@ubuntu.com>
In-Reply-To: <4DF6F1CD.9030001@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/17/2011 10:07 AM, Jean Delvare wrote:
> Hi Micah,
> 
> On Tue, 14 Jun 2011 00:29:49 -0500, Micah Gersten wrote:
>> I filed this bug [1] in Launchpad for Ubuntu and attached the
>> following patch:
>>
>>
>> +--- lm-sensors-3-3.2.0.orig/prog/detect/sensors-detect
>> ++++ lm-sensors-3-3.2.0/prog/detect/sensors-detect
>> +@@ -2258,7 +2258,8 @@ use vars qw(@kernel_version $kernel_arch
>> +
>> + sub initialize_kernel_version
>> + {
>> +-      `uname -r` =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
>> ++      #Third decimal only for point releases starting with 3.0
>> ++      `uname -r` =~ /(\d+)\.(\d+)(\.(\d+))?(.*)/;
>> +       @kernel_version = ($1, $2, $3, $4);
>> +       chomp($kernel_arch = `uname -m`);
>> +
> 
> Did you actually test your patch? I fail to see how it could work.
> @kernel_version would contain (2, 6, .39, 39) for kernel 2.6.39.1. I
> have the following instead:
> 
> @@ -2462,8 +2462,8 @@
>  
>  sub initialize_kernel_version
>  {
> -	`uname -r` =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
> -	@kernel_version = ($1, $2, $3, $4);
> +	`uname -r` =~ /(\d+)\.(\d+)(?:\.(\d+))?(.*)/;
> +	@kernel_version = ($1, $2, $3 || 0, $4);
>  	chomp($kernel_arch = `uname -m`);
>  
>  	# We only support kernels >= 2.6.5
> 
> which properly sets @kernel_version to (2, 6, 39, .1).
> 
> That being said, I would much prefer if Linus could just get a life and
> stick with 3-number versions, i.e. 3.0.0. Updating user-space at wide
> to cope with this change is just wasting everyone's time at the moment,
> for no benefit.
> 

I did test it, but regretfully, only on the 3.0 kernel.  I only noticed
your patch afterwards.  I think yours is the better way to do this, so
I"ll be updating my patch with yours.  Thanks for the feedback.  Looking
forward to this being included in a future release.

Thanks,
Micah

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
