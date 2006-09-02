From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 07:20:59 +0000
Subject: [lm-sensors] Analog Devices ADT7462
Message-Id: <20060902092059.8edc03df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <461784320609011632v550711e1md80dd2f360423528@mail.google.com>
In-Reply-To: <461784320609011632v550711e1md80dd2f360423528@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric,

> I see in the code that the ADT7462 detection is being added in
> sensors-detect.  But it is not listed on the device web page.  Is the actual
> driver under development?  IF so when is the expected availability of it.
> If not I will be using this part.  I have an evaluation board coming soon
> and would be happy to share my work or help test someone else's work.

I added detection for this chip and a bunch of other Analog Devices
ones while trying to identify a mysterious chip on a user's SMBus. The
chip happened to be an ADT7475, for which I added an entry in our "new
drivers" page. I did not add an entry for all other chips I added
detection for, as I don't even know if these chips will ever be used in
computers.

There is no driver under development for the ADT7462. Do you have a
system with an ADT7462? Looks like a beast... It looks like you will
have to write the driver yourself.

-- 
Jean Delvare

