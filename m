From: "Jean Delvare" <khali@linux-fr.org>
Date: Sat, 22 Dec 2007 11:34:07 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Support per-sensor alarm files
Message-Id: <NWhfFTFG.1198323247.5923820.khali@gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20071220185703.GT6870@tree.beaverton.ibm.com>
References: <20071219040123.GN6870@tree.beaverton.ibm.com>
In-Reply-To: <20071219040123.GN6870@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: djwong@us.ibm.com
Cc: lm-sensors <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>


Hi Darrick,

Le 20/12/2007, Darrick J. Wong =E9crit:

>On Thu, Dec 20, 2007 at 10:58:08AM +0100, Jean Delvare wrote:
>> BTW, did you try your driver with lm-sensors 3.0.0?
>
>Yes I did, and it looked ok to me.  Did you find something wrong?

No, I just wanted to make sure that you had tested it. Now that
libsensors relies on drivers implementing the standard sysfs interface,
it is a convenient way to verify that you implemented it properly.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
