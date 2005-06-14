From: per@computer.org (Per Jessen)
Date: Tue, 14 Jun 2005 20:07:18 +0000
Subject: [lm-sensors] My 333 DIMMs are only being recognised as 266 by the
Message-Id: <20050614180601.C5E4D8A3DA@mail.local.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <d8jidr$7rp$1@saturn.local.net>
In-Reply-To: <d8jidr$7rp$1@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Jun 2005 17:07:37 +0200, Rudolf Marek wrote:

>Hi Per,
>
>You can try decode yourself.
>As root you can do:
>modprobe i2c-dev
>i2cdump 0 0x50
>(0 is bus number, 0x50 is first dimm slot, adjust as needed, you can use sensors command to tell you 
bus and chip number)
>This will obtain memory dump to which you can apply DDR SPD specification
>http://www.jedec.org/download/search/4_01_02_10R13.pdf
>(or simply you can find it via google SPD DDR site:jedec.org)

Hi Rudolf,

thanks for the reply, but isn't this more or less what decode-dimms.pl does too?  That
is my understanding.  I know this is probably a little OT on this list, but I was hoping
someone could take a look at the listing from decode-dimms (http://jessen.ch/files/spd-decoded)
and explain to me (very slowly) what makes this DIMM 266MHz and not 333MHz ? 


/Per Jessen, Zurich

-- 
http://www.spamchek.com/freetrial - sign up for your 30-day free trial!


