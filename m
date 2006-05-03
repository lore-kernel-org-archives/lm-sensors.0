From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 03 May 2006 04:44:26 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new vt1211 driver
Message-Id: <191fb4ca0605022144j208fa753u49c3d715b49014d4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
In-Reply-To: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Just wondering when you might have the time to review the updated vt1211 driver?

Thanks
...juerg


> Incorporated suggestions made by Rudolf Marek.
>
> This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite of the
> existing vt1211 driver (by Mark D. Studebaker and Lars Ekman) that has been
> around for a while but never made it into the main kernel tree. It is
> implemented as a platform driver and therefore requires the latest CVS version
> of lm_sensors to function properly.
>
> Signed-off-by: Juerg Haefliger <juergh at gmail.com

