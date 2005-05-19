From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Sensors without module support
Message-Id: <41C99450.30403@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41C96B89.7050208@edeca.net>
In-Reply-To: <41C96B89.7050208@edeca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>> Is it possible to use lm-sensors without module support in the kernel?
> 
> Yes it is. However, this is not the most usual way to do, and has known
> problems (but workarounds exist).
[..]
> First, build a kernel with the only the bus driver you need (i2c-sis96x,
> obviously, and you should include i2c-isa as well). When running this
> kernel, run sensors-detect. It should work OK, and will tell you what
> chip driver you need. Recompile with this chip driver built-in and
> you're done.
> Of course if you already know for sure what chip driver you need, you
> can skip step 1 (in which case you don't need sensors-detect at all).
> Beware that we have 3 different drivers for Winbond chips (4 if you
> consider that the ASB100 is a Winbond clone).

Thank you for the mail.  I know exactly what chip I have (W83697HF) as
it says on it, therefore I could choose the right driver from the outset.

I have compiled a kernel with all the drivers as modules, then detected
them.  The results were as I expected, I now know exactly what drivers I
need and sensors works.

Thanks again,

David
