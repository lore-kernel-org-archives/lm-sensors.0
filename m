From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 26 Sep 2007 21:02:31 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <46FAC8E7.1000201@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> As announced last week, I released a first release candidate (rc1) of
> lm-sensors 3.0.0. The API is supposedly OK now, so it's time for
> application authors to try and port their applications to the new
> library and send us feedback.
> 
> Important changes compared to lm-sensors 2.10:
> * lm-sensors 3 only supports kernels 2.6.5 and later.
> * It is now a user-space-only package, it no longer contains kernel
>   drivers.
> * The i2c tools have been moved to a separate package (surprisingly
>   named i2c-tools).
> * libsensors version was bumped to 4.0.0, as it has a completely new
>   API we had to increase the .so version. This new library contains
>   no chip-specific knowledge, it assumes that hardware monitoring
>   drivers follow the standard sysfs interface.
> * The "sensors" binary has temporarily been renamed to "sensors3", so
>   that you can keep the old version around for comparison purpose. It
>   will be renamed back to "sensors" just before lm-sensors 3.0.0 is
>   released.
> * sensors.conf is not fully compatible between the old and the new
>   library. The lm-sensors 3 package includes a conversion script
>   from the old format to the new one.
> 
> There's one remaining open task for lm-sensors 3.0.0:
> http://www.lm-sensors.org/ticket/2174
> Mark, this is yours. If you don't think you'll have the time to
> implement it quickly, please move it to milestone 3.0.1.
> 
> lm_sensors-3.0.0-rc1.tar.gz is not signed yet. Phil, do you want to
> keep signing the archives for the lm-sensors 3 series? If you want to
> do it, please proceed. If you prefer that I take over, just say so and
> I'll do it.
> 
> Notes to application authors:
> * The new library has no chip-specific knowledge. As a result, the
>   <sensors/chips.h> header file is gone.
> * Pretty much all functions of the old API are gone or work
>   differently. If you need to test for the new library in some
>   configure script, sensors_get_features, sensors_get_all_subfeatures
>   and sensors_get_subfeature are good candidates. Alternatively, you
>   can test that the libsensors_version string starts with "3." or
>   explicitly ask for libsensors.so.4.
> * Reloading the configuration file with sensors_init() is no longer
>   supported, you need to explicitly call sensors_cleanup() before you
>   can call sensors_init() again.
> * There's no porting guide available. The new API is so different from
>   the old one that you're probably better looking at an application
>   using the new API to get an idea how it works. It's not very
>   difficult. The "sensors" and "sensord" applications that are part of
>   the lm-sensors package have been ported to the new API already, so
>   they are good examples. "sensors" in particular is very simple.
> 
> I've ported xsensors already, the patch is available here:
> http://jdelvare.pck.nerim.net/sensors/xsensors-libsensors4.patch
> 

Excellent work Jean! I've given this a test run on all my systems / test rigs 
and it works great everywhere. I'll create patches for ksensors, gkrellm, and 
gome's sensors-applet as time permits. I'm afraid this will take a while as 
currently I'm very busy with stuff regarding the upcoming Fedora 8.

Talking about Fedora as soon as the development branch gets unfrozen for the 
F-9 cycle I'll put this new lmsensors in Fedora's development branch (together 
with patches apps), so that it can get a good amount of testing there, this 
won't happen for a while though.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
