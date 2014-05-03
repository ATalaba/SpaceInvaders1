#include "eth_util.angelscript"

void main() {
	LoadScene("", "SceneLoad", "");
}

void SceneLoad() {
	AddEntity("player.ent", vector3(620, 680, 0), 0);
	for (int i = 1; i < 7; i++) {
		AddEntity("SkullClose.ent", vector3((130/*164*/+136*i), 420, 0), 0);
	}
	for (int j = 1; j < 7; j++) {
		AddEntity("SkullClose.ent", vector3((130+136*j), 340, 0), 0);
	}
	for (int m = 1; m < 7; m++) {
		AddEntity("InvaderClose.ent", vector3((130+136*m), 260, 0), 0);
	}
	for (int n = 1; n < 7; n++) {
		AddEntity("InvaderClose.ent", vector3((130+136*n), 180, 0), 0);
	}
	for (int o = 1; o < 7; o++) {
		AddEntity("TentacleClose.ent", vector3((130+136*o), 100, 0), 0);
	}
	for (int p = 1; p < 7; p++) {
		AddEntity("TentacleClose.ent", vector3((130+136*p), 20, 0), 0);
	}
	
}

void ETHCallback_player(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
int id;
if (input.KeyDown(K_A) && (thisEntity.GetPositionX() > 100))
	thisEntity.AddToPositionXY(vector2(-5.0f, 0.0f));
if (input.KeyDown(K_D) && (thisEntity.GetPositionX() < 1180))
	thisEntity.AddToPositionXY(vector2(5.0f, 0.0f));
if (input.GetKeyState(K_SPACE) == KS_HIT)
	id = AddEntity("bullet.ent", vector3(thisEntity.GetPositionXY(), 2.0f), 0);
	SeekEntity(id).SetInt("speed", 3);
}

void ETHCallback_bullet(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
	thisEntity.AddToPositionXY(vector2(0.0f, -3.0f));
	if (thisEntity.GetPositionX() < 0) {
	DeleteEntity(thisEntity);
	}
	//if (thisEntity.GetPositionXY()
}

void ETHCallback_SkullClose(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
	ETHEntityArray Skulls;
	GetEntityArray ("SkullClose.ent", Skulls);
	GetEntityArray ("InvaderClose.ent", Skulls);
	GetEntityArray ("TentacleClose.ent", Skulls);
	for (int m = 0; m < Skulls.Size(); m++) {
		if (thisEntity.GetPositionX() < 1180 && thisEntity.GetInt("move") == 1 and GetTime() % 500 == 0) {
		Skulls[m].AddToPositionXY(vector2(2.0f, 0.0f));
		} else if (thisEntity.GetPositionX() >= 1180 && thisEntity.GetInt("move") == 1) {
		Skulls[m].SetInt("move", 0);
		Skulls[m].AddToPositionXY(vector2(0.0f, 10.0f));
		}
		if (thisEntity.GetPositionX() > 100 && thisEntity.GetInt("move") == 0 and GetTime() % 500 == 0) {
		Skulls[m].AddToPositionXY(vector2(-2.0f, 0.0f));
		} else if (thisEntity.GetPositionX() <= 100 && thisEntity.GetInt("move") == 0) {
		Skulls[m].AddToPositionXY(vector2(0.0f, 10.0f));
		Skulls[m].SetInt("move", 1);
		}
	}
	/*if (thisEntity.GetPositionX() < 1180 && thisEntity.GetInt("move") == 1 and GetTime() % 500 == 0) {
	thisEntity.AddToPositionXY(vector2(20.0f, 0.0f));
	} else if (thisEntity.GetPositionX() >= 1180 && thisEntity.GetInt("move") == 1) {
	for(int i = 0; i < Skulls.Size(); i++){
	Skulls[i].SetInt("move", 0);
	}
	}
	if (thisEntity.GetPositionX() > 100 && thisEntity.GetInt("move") == 0 and GetTime() % 500 == 0) {
	thisEntity.AddToPositionXY(vector2(-20.0f, 0.0f));
	} else if (thisEntity.GetPositionX() <= 100 && thisEntity.GetInt("move") == 0) {
	for(int i = 0; i < Skulls.Size(); i++){
	Skulls[i].SetInt("move", 1);
	}
	} */
	if (GetTime() % 1000 == 0) {
		for(int k = 0; k < Skulls.Size();k++) {
			if (thisEntity.GetString("state") == "Open") {
			Skulls[k].SetSprite("entities/SkullClose.png");
			Skulls[k].SetString("state", "Close");
		}
		} }	else if (GetTime() % 500 == 0 && GetTime() % 1000 != 0) {
		for(int j = 0; j < Skulls.Size();j++){
			if (thisEntity.GetString("state") == "Close") {
			Skulls[j].SetSprite("entities/SkullOpen.png");
			Skulls[j].SetString("state", "Open");
			
		}
		}
}
}
void ETHCallback_TentacleClose(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
	ETHEntityArray Tentacles;
	GetEntityArray ("TentacleClose.ent", Tentacles);
	/*for (int m = 0; m < Tentacles.Size(); m++) {
		if (thisEntity.GetPositionX() < 1180 && thisEntity.GetInt("move") == 1 and GetTime() % 500 == 0) {
		Tentacles[m].AddToPositionXY(vector2(2.0f, 0.0f));
		} else if (thisEntity.GetPositionX() >= 1180 && thisEntity.GetInt("move") == 1) {
		Tentacles[m].SetInt("move", 0);
		}
		if (thisEntity.GetPositionX() > 100 && thisEntity.GetInt("move") == 0 and GetTime() % 500 == 0) {
		Tentacles[m].AddToPositionXY(vector2(-2.0f, 0.0f));
		} else if (thisEntity.GetPositionX() <= 100 && thisEntity.GetInt("move") == 0) {
		Tentacles[m].SetInt("move", 1);
		}*/
	
	/*if (thisEntity.GetPositionX() < 1180 && thisEntity.GetInt("move") == 1 and GetTime() % 500 == 0) {
	thisEntity.AddToPositionXY(vector2(20.0f, 0.0f));
	} else if (thisEntity.GetPositionX() >= 1180 && thisEntity.GetInt("move") == 1) {
	for(int i = 0; i < Tentacles.Size(); i++){
	Tentacles[i].SetInt("move", 0);
	}
	}
	if (thisEntity.GetPositionX() > 100 && thisEntity.GetInt("move") == 0 and GetTime() % 500 == 0) {
	thisEntity.AddToPositionXY(vector2(-20.0f, 0.0f));
	} else if (thisEntity.GetPositionX() <= 100 && thisEntity.GetInt("move") == 0) {
	for(int i = 0; i < Tentacles.Size(); i++){
	Tentacles[i].SetInt("move", 1);*/
	
		if (GetTime() % 1000 == 0) {
		for(int k = 0; k < Tentacles.Size();k++) {
		Tentacles[k].SetSprite("entities/TentacleClose.png");
		}
		} else if (GetTime() % 500 == 0 && GetTime() % 1000 != 0) {
		for(int j = 0; j < Tentacles.Size();j++){
		Tentacles[j].SetSprite("entities/TentacleOpen.png");
		}
		}
}
void ETHCallback_InvaderClose(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
	ETHEntityArray Invaders;
	GetEntityArray ("InvaderClose.ent", Invaders);
	/*for (int m = 0; m < Invaders.Size(); m++) {
		if (thisEntity.GetPositionX() < 1180 && thisEntity.GetInt("move") == 1 and GetTime() % 500 == 0) {
		Invaders[m].AddToPositionXY(vector2(2.0f, 0.0f));
		} else if (thisEntity.GetPositionX() >= 1180 && thisEntity.GetInt("move") == 1) {
		Invaders[m].SetInt("move", 0);
		}
		if (thisEntity.GetPositionX() > 100 && thisEntity.GetInt("move") == 0 and GetTime() % 500 == 0) {
		Invaders[m].AddToPositionXY(vector2(-2.0f, 0.0f));
		} else if (thisEntity.GetPositionX() <= 100 && thisEntity.GetInt("move") == 0) {
		Invaders[m].SetInt("move", 1);
		}
	}/*
	/*if (thisEntity.GetPositionX() < 1180 && thisEntity.GetInt("move") == 1 and GetTime() % 500 == 0) {
	thisEntity.AddToPositionXY(vector2(20.0f, 0.0f));
	} else if (thisEntity.GetPositionX() >= 1180 && thisEntity.GetInt("move") == 1) {
	for(int i = 0; i < Invaders.Size(); i++){
	Invaders[i].SetInt("move", 0);
	}
	}
	if (thisEntity.GetPositionX() > 100 && thisEntity.GetInt("move") == 0 and GetTime() % 500 == 0) {
	thisEntity.AddToPositionXY(vector2(-20.0f, 0.0f));
	} else if (thisEntity.GetPositionX() <= 100 && thisEntity.GetInt("move") == 0) {
	for(int i = 0; i < Invaders.Size(); i++){
	Invaders[i].SetInt("move", 1);*/
		if (GetTime() % 1000 == 0) {
		for(int k = 0; k < Invaders.Size();k++) {
		Invaders[k].SetSprite("entities/InvaderClose.png");
		}
		} else if (GetTime() % 500 == 0 && GetTime() % 1000 != 0) {
		for(int j = 0; j < Invaders.Size();j++){
		Invaders[j].SetSprite("entities/InvaderOpen.png");
		}
		}
}