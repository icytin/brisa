package brisa.repositories;

import javax.transaction.Transactional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import brisa.model.Status;

@Repository
@Transactional
public interface StatusRepository extends CrudRepository<Status, Long> {
	//public Status findByEvent(String event); funkade inte eftersom ny status skapas f�r varje uppladdning och det blir flera statusar med event fileupload. Gjorde s� att man sparar statusid vid uppladdning och kontrollerar mot denna ist�llet.
}