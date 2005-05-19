From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: 2.8.6 rpms at ATrpms
Message-Id: <1081330508.4073cb4c27c0f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040407083548.GB11271@neu.nirvana>
In-Reply-To: <20040407083548.GB11271@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've upgraded the Red Hat Linux/Fedora Core rpms to 2.8.6.

I'll mention that on our main page this evening.

> I will also reroll a new kernel with the dmi-scan patches soon
> (thanks for the patches, Jean, they seem to work fine).

Great. I'll apply the necessary changes to our CVS repository then.

> AFAICT these patches need to be simultaneously applied to kernel
> and lm_sensors (which will make their inclusion in 2.8.7 more
> difficult...)

I don't see why it would be more difficult. Remember that the fact that
I sent you three different patches is not relevant. The lm_sensors
dmi_scan patch will be integrated to our source tree, so you won't have
to care about it. Ditto for the mkpatch change. And the kernel patch
will be integrated into mkpatch, so you won't have to apply it
manually. This means that you won't have to take any different action.
You will just use mkpatch to generate the patch, and apply it to the
kernel tree.

Remember that the issue doesn't affect the compilation outside of the
kernel tree.

So it looks quite easy and straightforward, providing I update the
lm_sensors files as planned. Or did I miss a thing?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
