From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 19 Dec 2018 15:10:33 +0000
Subject: Re: libsensors soname bump
Message-Id: <20181219161033.348b8e94@endymion>
List-Id: <lm-sensors.vger.kernel.org>
References: <20181216124344.49d06b69@endymion>
        <05037889-f0ce-8f5b-2a35-b85170443883@redhat.com>
In-Reply-To: <05037889-f0ce-8f5b-2a35-b85170443883@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?T25kxZllaiBMeXNvbsSbaw==?= <olysonek@redhat.com>
Cc: linux-hwmon@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>, lordheavym@gmail.com, lm-sensors@vger.kernel.org

Hi Ondřej,

On Tue, 18 Dec 2018 18:06:00 +0100, Ondřej Lysoněk wrote:
> On 16. 12. 18 12:43, Jean Delvare wrote:
> > Would you consider quickly releasing lm-sensors 3.5.1 with the proper
> > library version number, to save all that work to all application
> > authors/maintainers and distribution package maintainers?  
> 
> I did consider it, but I'm afraid I can't do this, sorry. I'm afraid it
> would cause more problems than it would solve.
> 
> lm_sensors 3.5.0 has already been picked up by several distributions
> [1], and at least Arch Linux, Slackware and Gentoo have already rebuilt
> the dependent packages. It feels wrong to force the people, who already
> picked up the new version, to do the work again. I've spoken to the
> Gentoo maintainer and he's not thrilled about doing that. I'm really not
> looking forward to another batch of angry breakage reports after doing
> another soname change.
> 
> Doing the 3.5.1 release would also mean that everyone using 3.5.0 would
> have to upgrade, otherwise the values of the SENSORS_API_VERSION macro
> would be different on different systems, forcing users of that macro to
> deal with the mess.

OK. Thank you for taking the time to investigate the option. I
understand and respect your decision.

> I suggest that you use the patch that reverts the soname change in
> OpenSUSE, but keep the new SENSORS_API_VERSION so that it remains
> consistent with other distros.

You are right. I have reverted the change to SENSORS_API_VERSION from
my SUSE-local patch. While there was some beauty in having a
"structured" SENSORS_API_VERSION, there is a lot more value in using
the same value as upstream.

-- 
Jean Delvare
SUSE L3 Support
