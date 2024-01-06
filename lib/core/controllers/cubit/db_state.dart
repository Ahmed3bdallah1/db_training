abstract class DbState {}

class DbInitial extends DbState {}

class GetDbLoadingState extends DbState {}

class GetDbDoneState extends DbState {}

class GetDbErrorState extends DbState {}

class CreateDbInitialState extends DbState {}

class CreateDbDoneState extends DbState {}

class CreateDbErrorState extends DbState {}

class DeleteDbInitialState extends DbState {}

class DeleteDbDoneState extends DbState {}

class DeleteDbErrorState extends DbState {}

class AddDbInitialState extends DbState {}

class AddDbDoneState extends DbState {}

class AddDbErrorState extends DbState {}

class UpdateDbInitialState extends DbState {}

class UpdateDbDoneState extends DbState {}
