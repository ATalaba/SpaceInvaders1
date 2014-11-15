#include "eth_util.angelscript"
ETHEntityArray Skulls;
int lead, lead1, lead2;
ETHEntityArray Barriers;
ETHEntityArray EnemyBullet;
int player;
int time;
float velocity;

void main() {
	LoadScene("", "SceneLoad", "SceneRun");
}

void SceneLoad() {
int tempA, tempB, id;
	player = AddEntity("player.ent", vector3(620, 680, 0), 0);
	for (int q = 1; q < 5; q++) {
		AddScaledEntity("Barrier.ent", vector3((256*q), 570, 0), 2.0f);
	}
	GetEntityArray ("Barrier.ent", Barriers);
	for (int i = 1; i < 7; i++) {
		id = AddEntity("SkullClose.ent", vector3((130/*164*/+136*i), 420, 0), 0);
		if(i == 1){
			id = AddEntity("SkullClose.ent", vector3((130/*164*/+136*i), -100, 0), 0);
			SeekEntity(id).Hide(true);
			SeekEntity(id).SetInt("x",1);
			tempA = id;
			}
		if(i == 7) tempB = id;
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
	GetEntityArray ("SkullClose.ent", Skulls);
	GetEntityArray ("InvaderClose.ent", Skulls);
	GetEntityArray ("TentacleClose.ent", Skulls);
	for(int k = 0; k < Skulls.Size(); k++){
		if(Skulls[k].GetID() == tempA){
			lead1 = k;
			break;
			}
		}
	for(int v = 0; v < Skulls.Size(); v++){
		if(Skulls[v].GetID() == tempB){
			lead2 = v;
			break;
			}
		}
	
	lead = lead1;

}

void SceneRun(){
print(Skulls.Size());
	velocity = 3.7 - 0.1*Skulls.Size();
	for (int m = 0; m < Skulls.Size(); m++) {
		if (Skulls[m].GetPositionY() > 570) {
			LoadScene("scenes/Game_Over.esc");
			}
		if (Skulls[lead].GetPositionX() < 520 && Skulls[lead].GetInt("move") == 1 ){//and GetTime() % 500 == 0) {
		Skulls[m].AddToPositionXY(vector2(1.0f + velocity, 0.0f));
		} else if (Skulls[lead].GetPositionX() >= 520 && Skulls[lead].GetInt("move") == 1) {
		Skulls[m].SetInt("move", 0);
		//lead = lead1;
		Skulls[m].AddToPositionXY(vector2(0.0f, 20.0f));
		}
		if (Skulls[lead].GetPositionX() > 100 && Skulls[lead].GetInt("move") == 0){// and GetTime() % 500 == 0) {
		Skulls[m].AddToPositionXY(vector2(-1.0f - velocity, 0.0f));
		} else if (Skulls[lead].GetPositionX() <= 100 && Skulls[lead].GetInt("move") == 0) {
		Skulls[m].AddToPositionXY(vector2(0.0f, 20.0f));
		Skulls[m].SetInt("move",1);
			}
		
		int jd;
		Skulls[m].SetInt("prob", rand(100));
		if (Skulls[m].GetInt("prob") < 5 && GetTime() % 500 == 0 and Skulls[m].GetInt("x") != 1){
			jd = AddEntity("EnemyBullet.ent", vector3(Skulls[m].GetPositionXY(), 0), 0);
			SeekEntity(jd).SetInt("speed", 3);
			EnemyBullet.Insert(SeekEntity(jd));
		}
}
}

void ETHCallback_player(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
int id = -1;
	DrawText(vector2(30, 680), "LIVES = " + SeekEntity(player).GetInt("lives"), "Verdana14_shadow.fnt", ARGB(250, 255, 255, 255), 2.0f);
	if (input.KeyDown(K_A) && (thisEntity.GetPositionX() > 100))
	thisEntity.AddToPositionXY(vector2(-5.0f, 0.0f));
if (input.KeyDown(K_D) && (thisEntity.GetPositionX() < 1180))
	thisEntity.AddToPositionXY(vector2(5.0f, 0.0f));
if (input.GetKeyState(K_SPACE) == KS_HIT){
	if(GetTime() - time > 1000) {
		time = GetTime();
	id = AddEntity("bullet.ent", vector3(thisEntity.GetPositionXY(), 2.0f), 0);
	SeekEntity(id).SetInt("speed", 3);} 
}
}

void ETHCallback_bullet(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
	thisEntity.AddToPositionXY(vector2(0.0f, -3.0f));
	if (thisEntity.GetPositionY() < 0)	{
	DeleteEntity(thisEntity);
	}
	for(int i = 0; i < Skulls.Size(); i++){
	if(Skulls[i] != null and Skulls[i].GetInt("x") != 1 and distance(Skulls[i].GetPositionXY(),thisEntity.GetPositionXY()) <= 36){
		DeleteEntity(Skulls[i]);
		if(i < lead) lead--;
		Skulls.RemoveDeadEntities();
		DeleteEntity(thisEntity);
			
	}
}

	for(int i = 0; i < Barriers.Size(); i++){
	if(Barriers[i] != null and distance(Barriers[i].GetPositionXY(),thisEntity.GetPositionXY()) <= 44){
		if(Barriers[i].GetInt("lives") > 0){
			Barriers[i].AddToInt("lives",-1);
			DeleteEntity(thisEntity);
			}
			switch (Barriers[i].GetInt("lives")) {
		case 5: Barriers[i].SetSprite("entities/Barrier1.png");
		break;
		case 4: Barriers[i].SetSprite("entities/Barrier2.png");
		break;
		case 3: Barriers[i].SetSprite("entities/Barrier3.png");
		break;
		case 2: Barriers[i].SetSprite("entities/Barrier4.png");
		break;
		case 1: Barriers[i].SetSprite("entities/Barrier5.png");
		break;
		case 0: DeleteEntity(Barriers[i]);
				Barriers.RemoveDeadEntities();
				break;
		default: break;
		}
		}
	}
}

void ETHCallback_EnemyBullet(ETHEntity@ thisEntity) {
	thisEntity.AddToPositionXY(vector2(0.0f, 3.0f));
	if (thisEntity.GetPositionX() > 720){
	DeleteEntity(thisEntity);
	}
	for(int i = 0; i < Barriers.Size(); i++){
	if(Barriers[i] != null and distance(Barriers[i].GetPositionXY(),thisEntity.GetPositionXY()) <= 44){
		if(Barriers[i].GetInt("lives") > 0){
			Barriers[i].AddToInt("lives",-1);
			DeleteEntity(thisEntity);
			}
			switch (Barriers[i].GetInt("lives")) {
		case 5: Barriers[i].SetSprite("entities/Barrier1.png");
		break;
		case 4: Barriers[i].SetSprite("entities/Barrier2.png");
		break;
		case 3: Barriers[i].SetSprite("entities/Barrier3.png");
		break;
		case 2: Barriers[i].SetSprite("entities/Barrier4.png");
		break;
		case 1: Barriers[i].SetSprite("entities/Barrier5.png");
		break;
		case 0: DeleteEntity(Barriers[i]);
				Barriers.RemoveDeadEntities();
				break;
		default: break;
		}
		}
	}
	for(int j = 0; j < 1 ; j++) {
	if(SeekEntity(player) != null and distance(SeekEntity(player).GetPositionXY(),thisEntity.GetPositionXY()) <= 24) {
		if(SeekEntity(player).GetInt("lives") > 1) {
			DeleteEntity(thisEntity);
			SeekEntity(player).AddToInt("lives", -1);
			} else {
			LoadScene("scenes/Game_Over.esc");
			}
} } }

	/*thisEntity.AddToPositionXY(vector2(0.0f, 3.0f));
	if (thisEntity.GetPositionX() > 1280) {
	DeleteEntity(thisEntity);
	}
	for (int i = 0; i < Barriers.Size(); i++) {
	int Notlives = Barriers[i].GetInt("lives");
	if (Barriers[i] != null and distance(Barriers[i].GetPositionXY(), thisEntity.GetPositionXY()) <=44) {
		DeleteEntity(thisEntity);
		EnemyBullet.RemoveDeadEntities();
		switch (Barriers[i].GetInt("lives")) {
		case 5: Barriers[i].SetSprite("entities/Barrier1.png");
		break;
		case 4: Barriers[i].SetSprite("entities/Barrier2.png");
		break;
		case 3: Barriers[i].SetSprite("entities/Barrier3.png");
		break;
		case 2: Barriers[i].SetSprite("entities/Barrier4.png");
		break;
		case 1: Barriers[i].SetSprite("entities/Barrier5.png");
		break;
		case 0: DeleteEntity(Barriers[i]);
				Barriers.RemoveDeadEntities();
				break;
		default: break;
		}
		if (Barriers[i].GetInt("lives") > 0) {
			while (Barriers[i].GetInt("Notlives") == Barriers[i].GetInt("lives")) {
				DeleteEntity(thisEntity);
				EnemyBullet.RemoveDeadEntities();
				Barriers[i].AddToInt("lives", -1);
				}
			print(Barriers[i].GetInt("lives"));
			} 
			//	DeleteEntity(thisEntity);
			//DeleteEntity(Barriers[i]);
			//Barriers.RemoveDeadEntities();
		}
		//DeleteEntity(Barriers[i]);
		//Barriers.RemoveDeadEntities();
		//if(DeleteEntity(thisEntity) == null) print("x");
	}
}*/
void ETHCallback_SkullClose(ETHEntity@ thisEntity) {
ETHInput@ input = GetInputHandle();
	int jd;
	int prob;
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