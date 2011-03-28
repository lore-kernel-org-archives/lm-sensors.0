From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Mar 2011 19:19:57 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/3] hwmon: sht15: add support for
Message-Id: <20110328211957.644dbc9a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, 28 Mar 2011 12:46:55 -0400, Vivien Didelot wrote:
> On Sat, Mar 26, 2011 at 09:39:08PM +0100, Jean Delvare wrote:
> > I don't think it makes sense to let the platform data decide of this.
> > On the same system, different users may have different usage patterns
> > for the sysfs attributes.
>
> For this sht15_update_vals() function, I've decided to add a mask to
> specify which value should be read. i.e. the status register, the
> temperature and/or the humidity. For example, sht15_show_battery() will
> call sht15_update_vals(data, SHT15_UPDATE_STATE) and
> sht15_show_humidity() will call sht15_update_vals(data,
> SHT15_UPDATE_TEMP | SHT15_UPDATE_HUMIDITY) as the humidity calculation
> depends on the temperature. Btw, it avoids reading the humidity when
> only the temperature is requested.

That's interesting, I don't think any other driver ever implemented
things this way, but it should work. You'll have to use a separate cache
timestamp and validity flag for each register though, but given the
low number of register, it shouldn't be a problem in practice.

> > (...)
> > It boils down to coming up with a caching strategy which is optimal for
> > the use case. Historically, hwmon drivers have grouped register access
> > and have cached register values for three reasons.
> > 
> > The first reason is that some (old) sensor chips would stop sampling
> > when I2C was accessed, so letting any user read values continuously
> > from registers would let them DoS the monitoring, possibly with very
> > nasty effects (system overheating going unnoticed.) I don't think this
> > applies to the SHT1x, as sampling isn't done in the background to start
> > with.
> > 
> > The second reason is the slow access to registers. This holds for both
> > I2C and SPI devices, and definitely applies here. That being said, it
> > also depends on the number and size of registers. While we have I2C
> > hwmon devices with ~50 registers, The SHT1x only has 40 bits worth of
> > register values, this is really a small amount, so even with slow
> > register access, performance shouldn't suffer much. So I'm not entirely
> > sure if the ongoing discussing is really warranted.
> > 
> > The third reason is that sometimes different sysfs attributes map to
> > the same common register, so caching avoids duplicate register reads
> > (which is even more important for self-clearing registers.) For the
> > SHT1x, this would apply to temp1_fault and humidity1_fault, if we go
> > with these attributes as discussed elsewhere in this thread.
> > 
> > Anyway, the important thing to remember is that there is no universal
> > caching strategy. Different drivers have different implementations.
> > Some cache the values, some don't. Some have a single cache for all
> > register values (and thus a unique cache lifetime) while some partition
> > the registers in groups, and each group has its own cache lifetime. So
> > for the sht15 driver, depending on the most frequent usage pattern,
> > the current caching strategy (single cache for all registers and 1
> > second lifetime) may or may not be the most appropriate one.
> > 
> > One thing worth keeping in mind when deciding this is that "sensors"
> > will always read from all available attributes. So if it is the main
> > target, having a common cache for all register values needed by the
> > standard hwmon attributes makes sense. However, if there are other
> > targets (other monitoring tools with different access patterns, or
> > scripts accessing a single attribute repeatedly) then a different
> > approach may make more sense.
>
> Another reason could be that some sensors should not be solicited too
> much to prevent bad data readings. As an example, the datasheet says:
> "Important: To keep self heating below 0.1°C, SHT1x
> should not be active for more than 10% of the time – e.g.
> maximum one measurement per second at 12bit accuracy
> shall be made.". So caching in this case is crucial.

Good point.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
