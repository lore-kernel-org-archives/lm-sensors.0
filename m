From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 19 Aug 2006 11:36:45 +0000
Subject: [lm-sensors] Thinkpads still not supported?
Message-Id: <44E6F7CD.30507@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060811T155741-190@post.gmane.org>
In-Reply-To: <loom.20060811T155741-190@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> The SMBus is still blacklisted on IBM systems based on a PIIX4 chip.
> Your laptop probably has a more recent chip (Intel 82801), but anyway
> we've never seen a Thinkpad with a useable hardware monitoring chip as
> far as I remember, so it's probably not worth investigating. If you
> want to know the temperature laptop, try the "thermal" acpi driver
> instead.
> 
and also the ibm-acpi driver because it has more temps.

Regards
Rudolf

