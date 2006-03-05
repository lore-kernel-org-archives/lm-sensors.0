From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 05 Mar 2006 18:40:02 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0603051040h5259cf36ke64a112b2052d166@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
In-Reply-To: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I don't mean to be pushy but did anybody have a chance to look at my
vt1211 patch?

Thanks
...juerg


> [PATCH 1/2] hwmon: new vt1211 driver
>
> This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite of the
> existing vt1211 driver (by Mark D. Studebaker and Lars Ekman) that has been
> around for a while but never made it into the main kernel tree. It is
> implemented as a platform driver and therefore requires the latest CVS version
> of lm_sensors to function properly.
>
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> ---

