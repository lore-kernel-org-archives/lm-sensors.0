From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 22 Mar 2011 16:26:50 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon: sht15: add checksum
Message-Id: <20110322162650.GB4643@v0n.mtl.sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 22, 2011 at 10:19:37AM +0000, Jonathan Cameron wrote:
> >> This setting should definitely be configured via platform data.
> >> If there is reason to have it on for a given device, that is unlikely
> >> to only be true sometimes!
> > Yes, it will.
> Sorry, you lost me.  It will be true that you want checksum's only sometimes?
> If so please explain.
Sorry, I meant that it will be configured via platform data, because as
we discussed, there's no need to change checksumming during the runtime.

Regards,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
