From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 18:16:09 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080504201609.188de778@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, 04 May 2008 19:47:22 +0200, Achim Gottinger wrote:
> I searched the "Bios and Kernel Developer Guide" for smbus and found 
> those results
> 
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/31116.PDF
> 
> ------------------------------------------------------------------------------------------------
> • SMBus. System management bus. Refers to the protocol on which the 
> serial VID interface (SVI) commands
> and SBI are based. See section 2.4.1 [Processor Power Planes And Voltage 
> Control] on page 28, 2.13.3
> [Sideband Interface (SBI)] on page 123, and section 1.2 [Reference 
> Documents] on page 13.
> ------------------------------------------------------------------------------------------------
> 2.4.1 Processor Power Planes And Voltage Control
> 
> The processor includes the following power planes:
> • VDDIO: used for the DRAM and miscellaneous pins on DDR products only. 
> Voltage level is nominally 1.8V
> or 1.9V in support of DDR2; 1.5V in support of DDR3. This plane is 
> powered during S3 (suspend to RAM).
> • VTT: used for the DDR DRAM interface. Voltage level is specified to be 
> half of the VDDIO level. This
> plane is powered during S3 (suspend to RAM). See section 2.4.4 [ACPI 
> Suspend to RAM State (S3)] on
> page 52.
> • VLDT: used for each of the links. Voltage level is nominally 1.2V.
> • VDDA: filtered PLL supply. Voltage level is nominally 2.5V.
> • VDD or VDD[1:0]: main supply for core logic. “VDD” refers generically 
> to the core voltage plane(s). Voltage
> level is specified by the VID interface.
> • VDDNB: main supply for NB logic. Voltage level specified by the VID 
> interface.
> The voltage level of VDD and VDDNB may be altered in various states to 
> control power consumption. All the
> other supplies are fixed. Refer to the EDS for power plane sequencing 
> requirements.
> The processor includes two interfaces, intended to control external 
> voltage regulators, called the parallel VID
> (voltage level identifier) interface (PVI) and the serial VID interface 
> (SVI). The PVI is a simple 6-bit VID code
> provided on 6 pins. The SVI encodes voltage regulator control commands, 
> including the VID code, using
> SMBus protocol over two pins, SVD and SVC, to generate write commands to 
> external voltage regulators. The
> processor is the master and the voltage regulator(s) are the slave(s). 
> Both pins are outputs of the master; SVD is
> driven by the slave as well. SVC is a clock that strobes the data pin, 
> SVD, on the rising edge. Refer to the AMD
> ------------------------------------------------------------------------------------------------
> 2.13.3 Sideband Interface (SBI)
> 
> The sideband interface (SBI) is an SMBus v2.0 compatible 2-wire 
> processor slave interface. SBI is also
> referred as the Advanced Platform Management Link. All I2C v2.1 speeds 
> are supported.
> SBI is used to communicate withthe Temperature Sensor Interface (SB-TSI) 
> (see the SBI Temperature Sensor
> Interface (SB-TSI) Specification, #40821).
> ------------------------------------------------------------------------------------------------

There's probably a lot to read and do there, too bad I don't have the
time :(

> Information about the SBI SMBus register address can be read from the 
> pci register F3x1E8. lspci does not output values beyond 0xFF.

It does :) You only have to swap the bytes yourself due to x86 being
little-endian. Better use setpci with no value, you can tell it the
width of the register (.w for 16-bit, .l for 32-bit.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
