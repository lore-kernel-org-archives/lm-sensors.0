From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Sensors whackyness under 2.6.x
Message-Id: <3F4FF36B.6050503@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815110924.GC501@zip.com.au>
In-Reply-To: <20030815110924.GC501@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Once a second might be too fast.  I think the hardware can only go so 
fast and our driver tries to prevent too many queries in a short amount 
of time.  You might slow it down to 30 seconds or so.


Phil

CaT wrote:

>
>Cool. Will do that next. I'm planning on running sensors once a second and
>logging the output. Any debugging you'd like done while I'm at it?
>
>  
>
