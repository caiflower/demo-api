package hobby

import (
	"context"
	"fmt"
	"strings"

	"{{ .MODULE }}/model/api/hobby"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type HobbyImpl struct {
	hobby.UnimplementedHobbyServer
}

func (h *HobbyImpl) Search(ctx context.Context, req *hobby.SearchRequest) (*hobby.SearchResponse, error) {
	switch req.Query {
	case "1":
		if len(req.Hobby) >= int(req.GetPageNumber()) {
			return &hobby.SearchResponse{Code: 1, Message: req.Hobby[req.PageNumber-1]}, nil
		}

		return nil, status.Errorf(codes.InvalidArgument, fmt.Sprintf("pageNumber %v out of range", req.GetPageNumber()))
	case "2":
		return &hobby.SearchResponse{Code: 1, Message: strings.Join(req.Hobby, ",")}, nil
	}
	return nil, status.Errorf(codes.OutOfRange, fmt.Sprintf("query %v is not impl", req.Query))
}

func (h *HobbyImpl) Search3(req *hobby.SearchRequest) (*hobby.SearchResponse, error) {
	return h.Search(context.Background(), req)
}
