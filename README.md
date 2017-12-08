# distb Benchmarks

## How to Run

### Standard ProB
```
/path/to/prob/probcli -mc 99999999 -p PROOF_INFO false <model that should be checked>
```

### distb

Convenience script `parB2.sh` is included.
It requires to fix the `PROBCOMMAND` variable.

#### Running distb Manually

Run once per machine:

```
/path/to/prob/lib/proxy $MASTER_IP 5000 $IP 30 $LOGFILE_PROXY $PROXY_NUMBER
```

Note that on Linux systems you might need to set the `LD_LIBRARY_PATH` variable to find the ZeroMQ libraries beforehand:
```
export LD_LIBRARY_PATH=/path/to/prob/lib
```


Run once per model checking (5000 is the beginning of the TCP ports that are used):

```
/path/to/prob/probcli -bf -zmq_master2 0 $STATES 5000 0 $MASTER_IP $LOGFILE $MODEL
```

Run as many workers as you want:

```
/path/to/prob/probcli -zmq_worker2 $MASTER_IP 5000 $PROXY_NUMBER $LOGFILE_FOR_WORKER &
```


## Models


### `ModeProtocolMachine_mch.eventb`

The model was developed by Space Systems Finland as part of a Distributed System for Attitude and Orbit Control for a Single Spacecraft (DSAOCSS) System.  The model was a part of the case study within the EU Project DEPLOY.

See also: 

- Dubravka Ilic, Linas Laibinis, Timo Latvala, Elena Troubitsyna, and Kimmo Varpaaniemi. Deployment in the Space Sector. In Industrial Deployment of System Engineering Methods, pages 45–62. Springer, 2013.
- Dubravka Ilic, Timo Latvala, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, and Elena Troubitsyna. DEPLOY Deliverable D20 D3.1 - Report on Pilot Deployment in the Space Sector. Technical report, 2010. Available at http://www.deploy-project.eu/html/deliverables.html.
- Dubravka Ilic, Timo Latvala, Laura Nummila, Tuomas Räsänen, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, Yuliya Prokhorova, Elena Troubitsyna, Alexei Iliasov, Alexander Romanovsky, Michael Butler, Asieh Salehi Fathabadi, Abdolbaghi Rezazadeh, Jean-Christophe Deprez, Renaud De Landtsheer, and Christophe Ponsard. DEPLOY Deliverable D39 D3.2 - Report on Enhanced Deployment in the Space Sector. Technical report, 2011. Available at http://www.deploy-project.eu/html/deliverables.html.

### `obsw_M001.eventb`
This model was also developed by Space Systems Finland.
It models part of a system of a Mercury Planetary Orbiter.

See also: 

- Dubravka Ilic, Linas Laibinis, Timo Latvala, Elena Troubitsyna, and Kimmo Varpaaniemi. Deployment in the Space Sector. In Industrial Deployment of System Engineering Methods, pages 45–62. Springer, 2013.
- Dubravka Ilic, Timo Latvala, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, and Elena Troubitsyna. DEPLOY Deliverable D20 D3.1 - Report on Pilot Deployment in the Space Sector. Technical report, 2010. Available at http://www.deploy-project.eu/html/deliverables.html.
- Dubravka Ilic, Timo Latvala, Laura Nummila, Tuomas Räsänen, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, Yuliya Prokhorova, Elena Troubitsyna, Alexei Iliasov, Alexander Romanovsky, Michael Butler, Asieh Salehi Fathabadi, Abdolbaghi Rezazadeh, Jean-Christophe Deprez, Renaud De Landtsheer, and Christophe Ponsard. DEPLOY Deliverable D39 D3.2 - Report on Enhanced Deployment in the Space Sector. Technical report, 2011. Available at http://www.deploy-project.eu/html/deliverables.html.

### `earley_2.eventb`
This is a model of the earley parsing algorithm, written by <!-- TODO -->.


### `CAN_BUS_tlc.mch`
 <!-- TODO -->

### `Hanoi.mch`
This is a model of the famous Tower of Hanoi puzzle. It uses up to 15 discs.

### `Train_1_beebook_TLC.mch`

This interlocking system is a variation of the model from Abrial's book. The model has a reduced state space, which was achieved by manually applying a partial order reduction.

See also:
- Jean-Raymond Abrial. Modeling in Event-B: System and Software Engineering. Cambridge University Press, New York, NY, USA, 1st edition, 2010.

