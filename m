From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: call for 2.6.5 soon
Message-Id: <20020723081953.1e16e4a5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D3CBBA1.B4B210B0@paradyne.com>
In-Reply-To: <3D3CBBA1.B4B210B0@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Let's target the next release for mid-to-late August with
> Thinkpad bulletproofing in it. If you plan to add drivers for the next
> release please keep this schedule in mind.

Agreed. The sooner this problem is solved, the better.

As said earlier, I plan to add Sony Vaio eeprom support. This will
require changes to at least sensors-detect and sensors, and maybe also
at libsensors (I need to read strings from the eepreom, and as far as I
could see, the lib can only give me doubles).

Mark, I reconsidered your proposal and I'd like a CVS access. It'll be
more simple that way. Thanks.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
