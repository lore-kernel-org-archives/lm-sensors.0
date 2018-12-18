From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Tue, 18 Dec 2018 17:06:00 +0000
Subject: Re: libsensors soname bump
Message-Id: <05037889-f0ce-8f5b-2a35-b85170443883@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20181216124344.49d06b69@endymion>
In-Reply-To: <20181216124344.49d06b69@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-hwmon@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>, lordheavym@gmail.com, lm-sensors@vger.kernel.org

Hi Jean,

On 16. 12. 18 12:43, Jean Delvare wrote:
> Hi Ondřej,
> 
> You have recently released lm-sensors 3.5.0 with a new soname for
> libsensors:
> 
> -LIBMAINVER := 4
> -LIBMINORVER := 4.0
> +LIBMAINVER := 5
> +LIBMINORVER := 0.0
> 
> -#define SENSORS_API_VERSION            0x440
> +#define SENSORS_API_VERSION            0x500
> 
> This is declaring the new library as incompatible with the previous
> version, meaning that distributions will have to build and ship both
> libsensors4 and libsensors5 for a long time until all applications have
> been updated and rebuilt to link with the new library. This is a
> significant effort for the whole community and should only be done when
> necessary.
> 
> In this specific case, I can't see what warranted such a change of
> major library version change. From
> lm-sensors/doc/developers/release_checklist:
> 
>   Remember: update main number when interface changes, minor if new
>   functionality is added, and patch if only bugs are fixed.
> 
> In this case I can only see new functionality added, there is no
> interface change. Therefore the correct value for SENSORS_API_VERSION
> was 0x450, not 0x500. This would avoid the parallel maintenance and
> installation of 2 versions of the library for several years to come.
> 
> Would you consider quickly releasing lm-sensors 3.5.1 with the proper
> library version number, to save all that work to all application
> authors/maintainers and distribution package maintainers?

I did consider it, but I'm afraid I can't do this, sorry. I'm afraid it
would cause more problems than it would solve.

lm_sensors 3.5.0 has already been picked up by several distributions
[1], and at least Arch Linux, Slackware and Gentoo have already rebuilt
the dependent packages. It feels wrong to force the people, who already
picked up the new version, to do the work again. I've spoken to the
Gentoo maintainer and he's not thrilled about doing that. I'm really not
looking forward to another batch of angry breakage reports after doing
another soname change.

Doing the 3.5.1 release would also mean that everyone using 3.5.0 would
have to upgrade, otherwise the values of the SENSORS_API_VERSION macro
would be different on different systems, forcing users of that macro to
deal with the mess.

I suggest that you use the patch that reverts the soname change in
OpenSUSE, but keep the new SENSORS_API_VERSION so that it remains
consistent with other distros.

Thanks for understanding.

[1] https://repology.org/metapackage/lm-sensors/versions

Best regards
Ondřej Lysoněk
