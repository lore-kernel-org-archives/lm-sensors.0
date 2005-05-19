From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: i2c versioning
Message-Id: <20011127180330.N5595@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C043305.233767D@paradyne.com>
In-Reply-To: <3C043305.233767D@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 27, 2001 at 08:14:45PM -0500, Mark D. Studebaker wrote:
> You can do anything in code but I'm trying to call a function
> that doesn't exist in 2.6.2 or earlier so I need
> to do the comparison in the preprocessor in a #if statement
> so I don't get an undefined symbol.

I'd tend to lean towards being stubburn and not compiling than
littering the code with more #ifdef's if they are using an old I2C.
We've been updating I2C a lot for a while, but maybe we won't need to
as much in the future?


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
