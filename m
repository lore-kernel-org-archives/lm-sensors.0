From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Call for 2.8.0 soon
Message-Id: <3EE7EB7A.20707@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7C67A.4040703@paradyne.com>
In-Reply-To: <3EE7C67A.4040703@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark D. Studebaker wrote:
> 
> I think things are getting into shape here after a lot of work.
> Maybe we can do a release in a week or two?
> 
> Open issues, please comment or add to list:
> 
> - sensors-detect "UTF" issue
> - libsensors numbering because of binary incompatibility..... go to 
> 1.5.0 or 2.0.0?

What about going with 2.8.0...  Then track the lm_sensors version.

> - Delete sensors.h in sensors/include, move files?

Er... kernel/include

If we move sensors.h, should probably move i2c-dev.h from that directory 
as well...

> - Incompatibility w/ 2.4 kernel i2c structs
> - Need testing against kernel 2.4.9
> - Mkpatch - abandon, fix, what?
> - Update README, INSTALL, etc.
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
