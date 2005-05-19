From: od@fet.uni-hannover.de (Oliver Dawid)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [od@fet.uni-hannover.de: Trying to find device chrontel 7009 ...]
Message-Id: <20031017001828.C23459@bart.lan.fli4l>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031013205850.GA2164@frodo.local>
In-Reply-To: <20031013205850.GA2164@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 2003.10.14 22:24 Jean Delvare wrote:

> What you need to do is scan your i2c bus. Get the sensors-detect
> script
> that comes with lm_sensors, and run it. It should tell you which
> devices
> are available on your system. It will probably not identify your video
> decode chip, because it's mainly aimed at sensor chips, but at least
> it'll tell you at which address the chips were found (you can also use
> i2cdetect to obtain the same information).

Yeah, thanks. Thats the information i was looking for.

Regards,
od
