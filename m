From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Mar 2007 06:56:54 +0000
Subject: [lm-sensors] Call for 2.10.3
Message-Id: <20070315075654.8d022aa3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070303171327.186cd0f4.khali@linux-fr.org>
In-Reply-To: <20070303171327.186cd0f4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 3 Mar 2007 17:13:27 +0100, Jean Delvare wrote:
> I fear we'll have to release 2.10.3 earlier than originally planed. The
> sooner would be the better, in fact. Due to new i2c-core cleanups,
> libsensors needs again to be updated to anticipate the kernel changes
> and give our users (and distributions) a chance to upgrade user-space
> before upgrading their kernel, so they won't break "sensors" and other
> tools.
> 
> There is no bugfix pending as far as I know. If anyone thinks something
> in particular needs to be committed before we release 2.10.3, please
> speak up.
> 
> Release schedule could look like:
> * March 11th: SVN freeze
> * March 12th-18th: testing
> * March 19th: release

We're in the testing phase now, so everyone please test the current SVN
repository and make sure to report any bug you see.

Thanks,
-- 
Jean Delvare

