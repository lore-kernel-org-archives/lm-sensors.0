From: dma_k@mail.ru (Dmitry Katsubo)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: Compilation question
Message-Id: <4049DF95.1010500@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040222183932.46d8b4b9.khali@linux-fr.org>
In-Reply-To: <20040222183932.46d8b4b9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>After applying i2c-2.8.4.tar.gz to linux-2.4.25 the following options
>>are no longer compilable
>>What can be done to make them back again? Are they supported anymore?
> 
> Get my patch here:
> http://delvare.nerim.net/i2c/
> 
> This is the same as the one you'd obtain using mkpatch.pl, plus
> additional ones that workaround the compatibility issues you have been
> encountering.

Thank you very much for the link! I have just completed my compilation tests and it works perfectly 
for me. Possibly you may wish also to keep in touch with v4l-2 latest patch (v4l is knows to 
collaborate with lm_sensors):

ftp://bytesex.org/patches/2.4.25-rc1-1/

Thanks a lot.

Bye.
