From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Dec 2006 21:06:58 +0000
Subject: [lm-sensors] [PATCH 6/8] w83627ehf: Fix the detection of fan5
Message-Id: <20061207220658.89bedb8b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <11612021961186-git-send-email-greg@kroah.com>
In-Reply-To: <11612021961186-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Thu, 7 Dec 2006 14:01:19 -0700, David Hubbard wrote:
> I'm doing bits and pieces of the w83627dhg driver, and I want to make
> sure I test it on the latest patched w83627ehf driver. I believe this
> is Rudolf's last patch, the last update to the driver. However, the
> machine I develop on at home has a very slow internet connection, so I
> have tried linux-2.6.18-mm2 and linux-2.6.19-rc3. Neither seems to
> have that patch.
> 
> Has Rudolf's patch been pushed upstream? I'm replying on the thread
> where Greg K received the patch. Sorry, this should be an easy one,
> but I'm stuck.

The fan5 detection patch has been pushed upstream, it was merged in
2.6.19-rc3. There are no pending patches for the w83627ehf driver in my
tree so the version in 2.6.19-rc3 is the latest one.

-- 
Jean Delvare

