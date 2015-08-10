From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 10 Aug 2015 08:54:25 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: restrict Super I/O probing to x86
Message-Id: <20150810105425.507f758e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150809100048.GA8036@aurel32.net>
In-Reply-To: <20150809100048.GA8036@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

On Sun, 9 Aug 2015 12:00:48 +0200, Aurelien Jarno wrote:
> The current sensors-detect avoid Super I/O chips probing on
> PowerPC machines. However I have also been reported that this code
> can also crash ARM machines. I therefore believe the probing should
> be done only on x86 machines. The patch below changes that.

In general I am fine with the idea, hardware detection can be
troublesome so a white list feels safer than a black list. However I am
curious if these kind of chips can also be found on other
architectures? Maybe IA-64?

Well I suppose that other architectures can be added to the list later
if needed.

> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -6889,9 +6889,9 @@
>  	print "\n";
>  
>  	$superio_features = 0;
> -	# Skip "random" I/O port probing on PPC
> -	if ($kernel_arch ne 'ppc'
> -	 && $kernel_arch ne 'ppc64') {
> +	# Skip "random" I/O port probing on non x86 machines
> +	if ($kernel_arch =~ /i?86/

I've changed that to m/^i[3456]86$/ as it seems safer.

> +	 || $kernel_arch eq 'x86_64') {
>  		print "Some Super I/O chips contain embedded sensors. We have to write to\n".
>  		      "standard I/O ports to probe them. This is usually safe.\n";
>  		print "Do you want to scan for Super I/O sensors? (YES/no): ";
> 

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
